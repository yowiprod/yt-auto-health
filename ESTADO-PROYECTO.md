# Estado del Proyecto — JOTATIGER.FIT

## Última actualización: 2026-03-31

---

## HECHO ✅

- [x] Repositorio configurado en GitHub: `yowiprod/yt-auto-health`
- [x] Stack definido (100% gratuito salvo thumbnails ~$0.04)
- [x] Personaje definido: **Juan Fit** — hombre atlético 32-38 años, español, directo
- [x] `character.md` — definición completa del personaje + prompt para generar imagen
- [x] `script-generator.md` — prompt Groq para guiones de salud en español
- [x] `description-generator.md` — prompt SEO descripción YouTube
- [x] `title-generator.md` — prompt 5 títulos optimizados
- [x] `thumbnail-dalle.md` — prompt DALL-E 3 estética fitness
- [x] `seo-keywords.md` — keywords por cada una de las 8 playlists
- [x] `playlists.md` — 8 playlists con frecuencia, duración y ejemplos
- [x] `env.example` — variables de entorno completas
- [x] `test-voice.js` — test de voz XTTS v2 vía Colab

---

## STACK DEFINITIVO

```
n8n (orquestador, self-hosted)
  → Groq API — Llama 3.3 70B (guiones, títulos, descripciones) — GRATIS
  → Google Colab + XTTS v2 (voz masculina realista en español) — GRATIS
  → Google Colab + LatentSync (lip-sync sobre foto del avatar) — GRATIS
  → FFmpeg (montaje vídeo final) — GRATIS
  → DALL-E 3 (thumbnails) — ~$0.04/imagen
  → YouTube Data API v3 (subida automática) — GRATIS
  → Telegram Bot (notificaciones) — GRATIS
```

---

## PRÓXIMOS PASOS ⏳ (hacer en PC2)

### PASO 1 — Generar imagen del avatar Juan Fit
- Entrar a **leonardo.ai** (gratis)
- Modelo: Leonardo Kino XL o AlbedoBase XL
- Activar PhotoReal
- Dimensiones: 832x1216px
- Usar el prompt de `character.md`
- Negative prompt: `cartoon, anime, drawing, blurry, deformed, extra limbs, bad anatomy, watermark, text, logo, ugly, old`
- Elegir imagen con: cara centrada, boca neutral, sin oclusiones
- Guardar como `assets/juan-fit-avatar.jpg` y subir al repo

### PASO 2 — Notebook Google Colab: Voz (XTTS v2)
- Crear notebook con servidor Flask
- Endpoint POST `/tts` que recibe texto y devuelve audio .wav
- Voz masculina en español, grave y segura
- Exponer con ngrok
- Guardar URL en .env como COLAB_WEBHOOK_URL

### PASO 3 — Notebook Google Colab: Lip-sync (LatentSync)
- Crear notebook con LatentSync
- Endpoint POST `/lipsync` que recibe audio + imagen y devuelve vídeo .mp4
- Usar `assets/juan-fit-avatar.jpg` como imagen base
- Exponer con ngrok

### PASO 4 — Script FFmpeg de montaje
- Crear `scripts/build-video.js`
- Recibe: vídeo lip-sync + audio + intro/outro
- Devuelve: vídeo final .mp4 con branding

### PASO 5 — Flujo n8n completo
- Crear y exportar workflow n8n
- Nodos: Trigger → Groq (guión) → Groq (título+desc) → Colab TTS → Colab Lipsync → FFmpeg → DALL-E → YouTube → Telegram

### PASO 6 — Primer vídeo de prueba
- Tema: "3 errores que te impiden perder grasa"
- Playlist: Consejos Directos
- Verificar calidad de voz, lip-sync y vídeo final

---

## APIS Y CLAVES NECESARIAS

| Servicio | Dónde conseguirla | Coste |
|---|---|---|
| Groq API | console.groq.com | Gratis |
| OpenAI (DALL-E 3) | platform.openai.com | ~$5 créditos iniciales |
| YouTube OAuth2 | console.cloud.google.com | Gratis |
| Telegram Bot | @BotFather en Telegram | Gratis |
| ngrok | ngrok.com | Gratis (tier básico) |

---

## RAMA ACTIVA
`claude/review-setup-YW2v7` (con commits de Phase 1 + Phase 2 v4 + edits del 2026-05-13)

---

## SESIÓN 2026-05-13 — Resumen ejecutivo

### Lo que se VALIDÓ (no se mueve)

1. **HeyGen Video Agent funciona y entrega calidad alta** con avatar Photo Avatar IV (JuanFit). Test generó vídeo de 56s, estética "forense brutalista" naranja+negro, gancho inicial sin avatar + 3 mentiras alternando avatar/B-roll + cierre con logo. Coste por vídeo: ~20-30 créditos del wallet API.
2. **Chroma key sobre fondo negro NO sirve** para este avatar (cabello + shorts oscuros se confunden con el fondo). Plan v4 original con FFmpeg compositing → DESCARTADO.
3. **Submagic no es necesario** si HeyGen Video Agent ya hace captions + B-roll automático. Plan inicial de Phase 3 (FFmpeg + libass) tampoco necesario.
4. **Credencial OAuth de YouTube** lista en n8n local (cliente `n8n-jotatiger` en Google Cloud, secret nuevo creado y guardado solo en n8n).
5. **HeyGen tiene 2 pools de crédito separados**: web (plan mensual, ya pagado) y API (pay-as-you-go, hay que recargar). Workflows en n8n gastan API, no web.
6. **Identidad Juan Fit fusionada** (ver `character.md` actualizado): crítico con la industria + recomienda productos que él toma con experiencia personal, sin claims terapéuticos.

### Lo que se DECIDIÓ como plan

**Stack final del pipeline automatizado:**
- HeyGen Video Agent API (genera vídeo completo: avatar + B-roll Sora/Veo + captions)
- Publer Business (3 cuentas anual 16,36€/mes) — distribuye a YouTube + Instagram + TikTok
- n8n local — orquestación
- Coste estimado total: ~100-200€/mes según volumen (15-20 vídeos/mes)

**Mezcla de contenido** (objetivo 15 vídeos/mes):
- 8-9 educación pura
- 3 venta de producto (Evo Global, afiliación, productos propios futuros)
- 2 hook viral con clip real del creador
- 2 lifestyle/testimonio con clip real

### Lo que está PENDIENTE de hacer el usuario antes de retomar

1. **Suscribirse a Publer Business** (anual, 3 cuentas, ~196€/año)
2. **Recargar wallet API de HeyGen** ($20-50 para pruebas iniciales)
3. **Grabar banco de hooks reales**: una tarde de grabación con móvil vertical, 5-10 hooks (3-5s c/u) + 5-10 cierres (3-5s c/u). Incluir variantes con productos en mano (Té Detox EVO, suplementos, etc.) para los vídeos de tipo "Venta".

### Lo que se hace en la PRÓXIMA SESIÓN (refactor técnico)

1. Refactorizar `n8n/workflow-jotatiger-v4.json` al flujo nuevo:
   - Schedule Trigger
   - Decidir TIPO del vídeo (rotación o random ponderado: 55% Edu / 17% Venta / 13% Hook / 15% Lifestyle)
   - Groq con prompt distinto por tipo
   - HeyGen Video Agent API POST + polling
   - Si tipo es Hook/Lifestyle/Venta → FFmpeg combina clip real del usuario + avatar
   - Publer API POST → distribuye a YouTube + Instagram + TikTok
   - Telegram notif
2. Eliminar nodos Pexels (Video Agent ya genera B-roll).
3. Mantener Groq script generator pero adaptado por tipo.
4. Test end-to-end con un vídeo educativo primero (sin clip real, todo automatizado).

### Archivos tocados en esta sesión

- `PLAN-V4.md` — editado: cambio de chroma verde a negro (luego invalidado al descartar chroma)
- `n8n/workflow-jotatiger-v4.json` — refactor de credenciales (Groq, Pexels, HeyGen ahora usan credenciales separadas en lugar de keys hardcoded; queda pendiente refactor completo a Video Agent)
- `n8n/workflow-jotatiger-keys.json` — variante local con keys reales (gitignored)
- `n8n/uploader-manual.json` — workflow simple de upload manual a YouTube (3 nodos)
- `scripts/test-colorkey.bat` — script FFmpeg para validar colorkey (resultado: no viable con este avatar)
- `character.md` — actualizado con línea editorial de recomendaciones + tipos de vídeo
- `tmp/JOTATIGER.FIT_El_Fraude_de_la_Industria_Fitness_with_captions.mp4` — primer vídeo generado con Video Agent

### Secrets que se REVOCARON en esta sesión

Estaban hardcodeados en `n8n/workflow-jotatiger-v[234].json` commiteado al repo público:
- Groq API key (revocada)
- Pexels API key (revocada)
- HeyGen API key (revocada)
- Google OAuth client secret rotado en Google Cloud Console

---

## Estado del FORM TALLY (A MEDIO HACER al cerrar 2026-05-13)

**Cuenta:** `info.juanfit@gmail.com` (login email + password directo, no OAuth)
**URL editor:** https://tally.so/forms/rjG4Ep/edit
**Estado:** DRAFT (sin publicar)
**Spec completo:** ver `n8n/tally-form-spec.md`

**Lo que está creado en el editor:**
1. ✅ Título: "Asesoría personalizada — JOTATIGER.FIT"
2. ✅ Pregunta 1: ¿Cómo te llamas? (Short answer)
3. ✅ Pregunta 2: Tu email (Email)
4. ✅ Pregunta 3: Tu WhatsApp (Phone)
5. ⚠️ Pregunta 4: ¿Qué te interesa? (Multiple choice) — **BUG: opciones D-H mal**
6. ⚠️ Pregunta 5a: Tu objetivo principal (Multiple choice) — **vacía sin opciones**

**Bug pendiente de reparar (primer paso al retomar):**
- Opción D actual: "Aún no lo tengo claroPerder grasa" — corregir a "🤔 Aún no lo tengo claro"
- Eliminar opciones E, F, G, H (sobran, son de la pregunta 5a)
- Añadir opciones a 5a: Perder grasa / Más energía / Mejor digestión / Ganar músculo / Mejorar mi salud general

**Lo que falta crear:**
- Resto de pregunta 5a + opcionales 6a
- Sección 3B completa (5b, 6b, 7b)
- Sección 3C completa (5c, 6c)
- Sección 3D (5d)
- Sección 4 (cierre + GDPR)
- Lógica condicional para las 4 ramas

**Lección aprendida del automation:** después de añadir opciones a un multiple choice, NO basta con Escape para salir del modo edición — hay que hacer click explícito fuera del bloque antes del siguiente `/comando`. Si no, los textos se concatenan con la última opción.

---

## Cómo retomar esto en nueva sesión Claude

Primer mensaje sugerido para abrir nueva sesión:

> *"Lee `ESTADO-PROYECTO.md` y `n8n/tally-form-spec.md`. Retomamos el form de Tally desde donde lo dejé: hay que reparar el bug de la pregunta 4 y completar el resto del form."*

Eso reduce la fricción inicial a cero — la nueva sesión sabe exactamente dónde estamos y qué hacer.

Los workflows en HEAD ya no contienen secrets en plain text. Pendiente: limpiar git history para que las keys viejas no estén en commits antiguos (opcional, ya están revocadas).
