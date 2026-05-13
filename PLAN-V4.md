# PLAN V4 — Pipeline de Vídeo con B-Roll Sincronizado

**Proyecto:** JOTATIGER.FIT · canal YouTube de salud y fitness
**Autor del plan:** documento de diseño previo a implementación
**Estado:** PENDIENTE DE IMPLEMENTAR

---

## Objetivo

Evolucionar el pipeline actual (v3) para que los vídeos tengan un estilo visual similar al canal **"Minutos de Salud"** (vídeo de referencia: https://youtu.be/tbLuWNbOEgU).

**Qué aporta v4 respecto a v3:**

- Imágenes/vídeos de fondo **sincronizados con el guión** (aparece la imagen correspondiente cuando se menciona el concepto).
- **Título grande** apareciendo al principio del vídeo.
- **Logo watermark** en esquina durante todo el vídeo.
- **Dos formatos de salida** por cada vídeo generado: horizontal (1920x1080) y vertical (1080x1920).

---

## Resumen del pipeline v4

```
1. Groq → genera guión (ya existe en v3)
2. Groq → genera título, descripción, playlist (ya existe en v3)
3. Groq → [NUEVO] analiza el guión y devuelve lista de "segmentos" con palabras clave
4. Pexels → [MODIFICADO] busca B-rolls múltiples (uno por segmento), en horizontal y vertical
5. HeyGen → [MODIFICADO] genera avatar con fondo VERDE CHROMA (sin B-roll de HeyGen)
6. Whisper (o HeyGen API) → [NUEVO] obtiene timings palabra-por-palabra del audio
7. FFmpeg → [NUEVO] montaje sincronizado con chroma key, B-rolls, título, logo
8. Generar los dos formatos (horizontal + vertical) como salidas separadas
9. YouTube → sube el horizontal al canal principal (ya existe en v3)
10. YouTube Shorts (o TikTok/Reels) → sube el vertical [futuro, fuera de alcance v4]
11. Telegram → notifica (ya existe en v3)
```

**Lo nuevo ("[NUEVO]" o "[MODIFICADO]"):** pasos 3, 4, 5, 6, 7, 8. Lo demás se mantiene del v3.

---

## Componentes y decisiones

### Avatar (HeyGen)

- **Avatar:** Juan Fit (ID actual del v3)
- **Voz:** Efrayn (español)
- **Fondo:** NEGRO (#000000), nativo del Photo Avatar IV cuando no se le indica otro background válido.
- **Formato de salida HeyGen:** 1080x1920 (vertical). Se reformateará luego en FFmpeg para las dos orientaciones.
- **Razón del negro (no verde):** Photo Avatar + Avatar IV ignora `background.type=color` por API (solo lo soportan los Studio Avatars de HeyGen). El render sale con su default, que es un negro uniforme — funcionalmente equivalente a un chroma para nuestro caso: el avatar lleva camiseta/shorts azules, calcetines/zapatillas blancas y piel humana, ningún elemento coincide con negro puro. Verificado contra doc oficial de HeyGen (`/docs/customize-video-background`, `/docs/create-webm-avatar-videos`). El WebM con alpha no aplica porque solo soporta Studio Avatars, no Photo Avatars custom como Juan Fit.

### B-roll dinámico (Pexels)

- **Fuente:** Pexels (ya integrado en v3, API gratuita)
- **Cantidad por vídeo:** aproximadamente 1 B-roll cada 5-10 segundos de guión, decidido dinámicamente por Groq en el paso 3.
- **Orientación:** se hacen dos búsquedas por cada keyword (landscape + portrait) para tener B-roll en ambos formatos.
- **Fallback:** si Pexels no devuelve resultado para una keyword específica, se usa el B-roll genérico de la keyword principal del vídeo (como hace el v3 ahora).

### Análisis del guión (Groq, nuevo paso)

- **Modelo:** `llama-3.3-70b-versatile` (el mismo que ya usa v3)
- **Input:** guión limpio + duración estimada del audio
- **Output:** JSON con estructura
  ```json
  {
    "segments": [
      { "start_seconds": 0, "end_seconds": 4, "keyword": "brain anatomy" },
      { "start_seconds": 4, "end_seconds": 9, "keyword": "person sleeping" },
      { "start_seconds": 9, "end_seconds": 14, "keyword": "pizza unhealthy food" },
      ...
    ],
    "main_title": "3 errores que destruyen tu memoria"
  }
  ```
- **Prompt:** se guardará en un archivo separado `broll-segmenter.md` para poder iterarlo.

### Timings palabra-por-palabra

- **Opción preferida:** si HeyGen ofrece timings en la respuesta de su API, usarlos directamente.
- **Alternativa:** usar **Whisper** (OpenAI, local con whisper-cpp o vía Replicate/Colab gratis) para transcribir el audio de HeyGen y obtener timings.
- **Decisión pendiente:** confirmar en implementación qué opción usa HeyGen exactamente.

### Montaje FFmpeg (nuevo script)

- **Ubicación:** `scripts/build-video.js` (el archivo que el ESTADO-PROYECTO.md ya tenía pendiente desde marzo).
- **Lenguaje:** Node.js (encaja con el stack actual del repo).
- **Entrada:**
  - `avatar.mp4` (HeyGen con fondo verde)
  - `brolls/*.mp4` (array de B-rolls de Pexels)
  - `segments.json` (output del análisis de Groq)
  - `main_title` (texto)
  - `logo.png` (asset del repo)
  - `format` ("horizontal" | "vertical")
- **Salida:** `output.mp4` montado y listo para subir.
- **Operaciones FFmpeg en pseudo-código:**
  1. Cargar avatar, aplicar `colorkey=0x000000:0.3:0.1` (quitar negro nativo del Photo Avatar IV — afinar `similarity`/`blend` durante validación para no morder el cabello)
  2. Cargar B-rolls, concatenarlos respetando los `start_seconds`/`end_seconds` de cada segmento
  3. Aplicar `overlay` para poner el avatar (sin negro) encima del B-roll
  4. Generar un título `.ass` con libass y overlay en los primeros 3 segundos
  5. Overlay del logo PNG en la esquina durante todo el vídeo
  6. Exportar al formato solicitado (escalar + crop según orientación)

### Formato doble (horizontal + vertical)

- **Una sola pasada de HeyGen** (vertical), pero dos pasadas de FFmpeg.
- **Horizontal (1920x1080):**
  - Avatar se ve a tamaño pequeño en la derecha (tipo presentador de telediario)
  - B-roll ocupa el fondo entero (full bleed)
  - Título grande en tercio inferior
  - Logo en esquina superior derecha
- **Vertical (1080x1920):**
  - Avatar se ve grande en el centro
  - B-roll ocupa el fondo entero
  - Título grande arriba
  - Logo en esquina inferior derecha

### Logo

- **Archivo:** `assets/jotatiger-logo.png` (a guardar en el repo)
- **Características:** PNG transparente, tigre con mancuernas
- **Tamaño en vídeo horizontal:** ~8% del ancho, esquina superior derecha
- **Tamaño en vídeo vertical:** ~15% del ancho, esquina inferior derecha (no tapar subtítulos de YouTube Shorts)
- **Opacidad:** 80% (para no molestar sobre el B-roll)

### Títulos (libass)

- **Fuente:** Montserrat Bold (si no, Arial Bold como fallback)
- **Tamaño:** 60pt horizontal / 72pt vertical
- **Color:** blanco con borde negro o amarillo fitness (#FFD700)
- **Duración:** primeros 3 segundos del vídeo
- **Animación:** fade-in 0.3s + permanencia 2.4s + fade-out 0.3s
- **Posición:** centrado horizontalmente, tercio inferior en horizontal / tercio superior en vertical

---

## Fases de implementación

El plan se construye en **7 fases pequeñas**, cada una probable en aislamiento antes de seguir a la siguiente. Si alguna falla, paramos y arreglamos antes de avanzar.

### Fase 1 — Preparación del repo (30 min)

- Guardar `assets/jotatiger-logo.png` en el repo
- Crear archivo `PLAN-V4.md` (este documento) y commitearlo
- Crear archivo vacío `scripts/build-video.js`
- Actualizar `CLAUDE.md` con las nuevas rutas y convenciones del v4
- Commit y push

### Fase 2 — HeyGen con fondo apto para chroma (30 min)

- Configurar el nodo "Preparar HeyGen" en v4 para no enviar B-roll (sin `assetUrl` ni `background.type=video`). El parámetro `background.type=color` es opcional: HeyGen lo ignora en Photo Avatar IV y devuelve negro nativo igualmente, así que se omite del payload para reducir ruido.
- Probar manualmente una ejecución en n8n (sin FFmpeg todavía).
- **Criterio de éxito (revisado):** el vídeo resultante tiene un fondo uniforme apto para colorkey en FFmpeg. En la práctica con Photo Avatar IV es negro liso. Validación funcional al final de Fase 3 con `colorkey=0x000000`.

### Fase 3 — FFmpeg: chroma key básico (1h)

- Crear `scripts/build-video.js` primera versión: recibe avatar + 1 imagen fondo + salida, aplica chroma key y overlay, exporta MP4.
- Probar con archivos de ejemplo (sin n8n, desde terminal).
- Verificar calidad del recorte del avatar.

### Fase 4 — Segmentación del guión (1h)

- Escribir prompt `broll-segmenter.md` para Groq.
- Probar con un guión existente y ver si devuelve JSON bien estructurado.
- Añadir nodo nuevo en n8n "Segmentar guión" que use este prompt.

### Fase 5 — Múltiples B-rolls en FFmpeg (1h)

- Ampliar `build-video.js` para aceptar array de B-rolls con tiempos.
- Concatenarlos respetando los `start_seconds`/`end_seconds`.
- Probar con 3-5 B-rolls encadenados.

### Fase 6 — Textos y logo (1h)

- Añadir overlay de título (libass) y logo a `build-video.js`.
- Probar.

### Fase 7 — Integración completa en n8n (1-2h)

- Encadenar todos los nodos nuevos con los existentes del v3.
- Añadir nodo que llame al script `build-video.js` local.
- Generar los dos formatos.
- Prueba end-to-end con un vídeo real.
- Si funciona, fusionar a `main`.

**Total estimado: 5-7 horas de trabajo efectivo, distribuibles en varias sesiones.**

---

## Qué NO está en el alcance del v4

Para no dispersarnos, estas cosas **se quedan fuera** de este plan y se harán en iteraciones futuras:

- Sincronización palabra-por-palabra ultra-precisa (v4 sincroniza por segmentos de 5-10s, no por palabra exacta)
- Subtítulos en pantalla (lo que dice el avatar como texto)
- Animaciones de entrada/salida fancy de los B-rolls (solo corte simple)
- Subida automática del vertical a Shorts/TikTok/Reels (solo se genera el archivo)
- Música de fondo
- Transiciones entre B-rolls (solo cortes duros de momento)

Todo esto se puede añadir en v5, v6, etc.

---

## Riesgos y mitigaciones

| Riesgo | Mitigación |
|---|---|
| HeyGen no da timings en la respuesta API | Fallback: Whisper local o vía Colab gratis |
| Pexels no encuentra B-roll para alguna keyword | Fallback: usar B-roll genérico del tema principal |
| Colorkey muerde el cabello oscuro o las sombras del cuello | Bajar `similarity` (0.1-0.2) y subir `blend` (0.05-0.15). Si persiste, aplicar `despill` o caer a matting por ML como último recurso |
| El PC local no aguanta render de FFmpeg | Usar presets rápidos (`-preset veryfast`), o mover el render a Colab |
| El script falla en producción | Cada fase se prueba en aislamiento, no se avanza sin tener la anterior sólida |

---

## Archivos que se crearán o modificarán

**Nuevos:**
- `PLAN-V4.md` (este archivo)
- `scripts/build-video.js` (nuevo script de montaje)
- `assets/jotatiger-logo.png` (el logo)
- `broll-segmenter.md` (prompt para Groq)
- `n8n/workflow-jotatiger-v4.json` (workflow nuevo, NO se modifica v3)

**Modificados:**
- `CLAUDE.md` (añadir convenciones del v4)
- `ESTADO-PROYECTO.md` (marcar fases completadas)

**Respetados (no tocar):**
- `n8n/workflow-jotatiger-v3.json` (queda como red de seguridad)
- `n8n/workflow-jotatiger-v2.json`, `workflow-jotatiger.json` (históricos)
- Todos los archivos `.md` de prompts (character, script-generator, etc.)
