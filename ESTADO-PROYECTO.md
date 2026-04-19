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
`claude/init-youtube-automation-5QNK5`
