# Tally Form Spec — Asesoría personalizada JOTATIGER.FIT

**Propósito:** capturar leads desde los vídeos de Juan Fit. El usuario rellena este form, llega como webhook a n8n, n8n te avisa por Telegram, tú contactas desde tu cuenta personal por WhatsApp.

**URL del form en Tally (en construcción):** https://tally.so/forms/rjG4Ep/edit (workspace de `info.juanfit@gmail.com`)

**Cuenta Tally:** `info.juanfit@gmail.com` (login email + password, no OAuth)

---

## Estado actual (cuando se cerró la sesión 2026-05-13)

**Lo que ESTÁ hecho en el form:**

- ✅ Título: `Asesoría personalizada — JOTATIGER.FIT`
- ✅ Pregunta 1: `¿Cómo te llamas?` (Short answer, *)
- ✅ Pregunta 2: `Tu email` (Email, *)
- ✅ Pregunta 3: `Tu WhatsApp` (Phone number, *)
- ⚠️ Pregunta 4: `¿Qué te interesa?` (Multiple choice, *) — **CREADA CON BUG**
- ⚠️ Pregunta 5a: `Tu objetivo principal` (Multiple choice) — **CREADA VACÍA SIN OPCIONES**

**El bug de la pregunta 4:** las opciones se desbordaron porque el automation no salió a tiempo del modo edición de la última opción. Estado actual de la pregunta 4:

```
A: 🛒 Quiero probar productos (suplementos, té, etc.)     ← OK
B: 💼 Quiero saber cómo ganar dinero recomendando productos  ← OK
C: 🎯 Quiero asesoramiento personal (fitness / nutrición)    ← OK
D: 🤔 Aún no lo tengo claroPerder grasa                       ← ROTO (texto concatenado)
E: Más energía / menos cansancio                              ← SOBRA (es de pregunta 5a)
F: Mejor digestión                                            ← SOBRA
G: Ganar músculo                                              ← SOBRA
H: Mejorar mi salud general                                   ← SOBRA
```

**Reparación necesaria** antes de continuar:
1. Click en D → borrar `Perder grasa` del final → debe quedar solo `🤔 Aún no lo tengo claro`
2. Eliminar opciones E, F, G, H (cada una: click en el icono basurero a la izquierda de la opción)
3. La pregunta 5a (`Tu objetivo principal`) ya existe pero VACÍA — añadirle las opciones del spec abajo

---

## Spec completo (lo que falta construir desde la reparación)

### Sección 1 — Datos básicos ✅ HECHO

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 1 | Short answer | ¿Cómo te llamas? | ✅ |
| 2 | Email | Tu email | ✅ |
| 3 | Phone number | Tu WhatsApp | ✅ |

### Sección 2 — Bifurcación ⚠️ HECHA CON BUG (reparar)

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 4 | Multiple choice (single) | ¿Qué te interesa? | ✅ |

**Opciones de la pregunta 4** (debe quedar EXACTAMENTE así, solo 4):

- A: 🛒 Quiero probar productos (suplementos, té, etc.)
- B: 💼 Quiero saber cómo ganar dinero recomendando productos
- C: 🎯 Quiero asesoramiento personal (fitness / nutrición)
- D: 🤔 Aún no lo tengo claro

### Sección 3A — Rama "Productos" ⚠️ PARCIAL (5a existe vacía)

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 5a | Multiple choice (single) | Tu objetivo principal | ✅ |
| 6a | Short answer | ¿Estás tomando algún suplemento ahora? | ❌ (opcional) |

**Opciones de 5a:** Perder grasa / Más energía / menos cansancio / Mejor digestión / Ganar músculo / Otro

### Sección 3B — Rama "Ganar dinero" ❌ FALTA

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 5b | Multiple choice (single) | ¿Cuánto tiempo a la semana podrías dedicar? | ✅ |
| 6b | Long answer | ¿Por qué te interesa? (opcional, máx 200 caracteres) | ❌ |
| 7b | Multiple choice (single) | ¿Tienes experiencia en ventas o recomendación? | ❌ |

**Opciones 5b:** Menos de 5h / 5-10h / Más de 10h / Tiempo completo
**Opciones 7b:** Sí / No / Un poco

### Sección 3C — Rama "Asesoramiento personal" ❌ FALTA

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 5c | Multiple choice (single) | ¿En qué área quieres asesoría? | ✅ |
| 6c | Long answer | Cuéntanos tu situación actual en 1-2 frases | ❌ |

**Opciones 5c:** Pérdida de grasa / Ganar músculo / Mejorar mi alimentación / Mejorar mi salud general / Mi rutina de entrenamiento

### Sección 3D — Rama "Aún no lo tengo claro" ❌ FALTA

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 5d | Long answer | Cuéntanos qué te trajo a JOTATIGER.FIT | ❌ |

### Sección 4 — Cierre común ❌ FALTA

| # | Tipo | Pregunta | Obligatorio |
|---|---|---|---|
| 8 | Multiple choice (single) | ¿Cómo nos conociste? | ❌ |
| 9 | Text block | Aviso de transparencia (no pregunta) | — |
| 10 | Checkbox (single) | He leído y acepto el aviso. Soy mayor de 18 años | ✅ |

**Opciones 8:** YouTube / TikTok / Instagram / Recomendación / Otro

**Texto del bloque 9 (copy literal):**

> ⚠️ Juan Fit es un personaje generado con inteligencia artificial. Detrás del canal hay un equipo humano que te escribirá personalmente por WhatsApp en menos de 48 horas. Sin venta agresiva, sin spam, sin compromiso.
>
> Tus datos se tratan según el RGPD y solo se usan para contactarte. Puedes solicitar su eliminación en cualquier momento escribiendo a info.juanfit@gmail.com.

---

## Lógica condicional (pendiente al final)

Cuando todos los bloques estén creados, configurar Logic en cada pregunta condicional:

- **5a + 6a (sección 3A)**: mostrar SOLO si pregunta 4 = "🛒 Quiero probar productos"
- **5b + 6b + 7b (sección 3B)**: mostrar SOLO si pregunta 4 = "💼 Quiero saber cómo ganar dinero"
- **5c + 6c (sección 3C)**: mostrar SOLO si pregunta 4 = "🎯 Quiero asesoramiento personal"
- **5d (sección 3D)**: mostrar SOLO si pregunta 4 = "🤔 Aún no lo tengo claro"

**Cómo se configura en Tally:** Click en el bloque → menú "Logic" (icono de flecha bifurcada en la barra superior) → "Show this block if..." → seleccionar pregunta 4 + valor.

---

## Después de publicar el form

1. Pulsar **Publish** arriba a la derecha → Tally te da una URL pública del form
2. Anotar esa URL en `ESTADO-PROYECTO.md` (sección "Form Tally URL pública")
3. Configurar **Webhook integration** en Tally (Settings → Integrations → Webhook → meter URL del webhook de n8n)
4. En la próxima sesión técnica: refactor v4 + integración Publer + webhook Tally lead → Telegram notif

---

## Notas para nueva sesión Claude (cómo retomar)

1. Lee `ESTADO-PROYECTO.md` primero (resumen ejecutivo)
2. Lee este archivo (`n8n/tally-form-spec.md`) para conocer el form
3. Para automatizar Tally vía Claude in Chrome:
   - Chrome con sesión activa: `work` (deviceId `d6198487-cb4c-4081-b4bc-10dfe8036ec1`)
   - Login Tally: `info.juanfit@gmail.com` con password directo (NO OAuth Google porque la cuenta Google `info.juanfit` no está logueada en Chrome — el password del usuario lo introduce él manualmente)
   - URL del form: https://tally.so/forms/rjG4Ep/edit
4. **Primer paso al retomar**: reparar la pregunta 4 (eliminar opciones E-H, corregir D) **antes** de seguir añadiendo bloques. Las 4 primeras preguntas están bien.
5. **Lección aprendida**: cuando estés añadiendo opciones a un multiple choice y quieras pasar al siguiente bloque, hacer click EXPLÍCITO fuera del bloque antes de empezar el siguiente. No fiarse solo de Escape — a veces no sale del modo edición de la última opción y el siguiente "Type /" se concatena con el texto de la opción.
