# JOTATIGER.FIT — YouTube Automation

Canal de YouTube automatizado con avatar realista (Juan Fit).

## Stack
- **Groq API** (Llama 3.3 70B) — guiones, títulos, descripciones, SEO (GRATIS)
- **Google Colab + XTTS v2** — voz masculina realista en español (GRATIS)
- **Google Colab + LatentSync** — lip-sync sobre imagen del avatar (GRATIS)
- **FFmpeg** — montaje de vídeo final (GRATIS)
- **YouTube Data API v3** — subida automática (GRATIS)
- **DALL-E 3** — thumbnails (~$0.04 por imagen)
- **Telegram Bot** — notificaciones (GRATIS)
- **n8n** — orquestador del flujo completo (GRATIS self-hosted)

## Coste estimado por vídeo: ~$0.04

## Listas de reproducción
1. Consejos Directos
2. Motivación
3. Comida — Alternativas Saludables
4. Complementos
5. Pérdida de Grasa
6. Músculo
7. Salud General
8. Longevidad

## Archivos clave
| Archivo | Descripción |
|---|---|
| `character.md` | Definición del personaje Juan Fit |
| `script-generator.md` | Prompt para generar guiones |
| `description-generator.md` | Prompt para descripción SEO |
| `title-generator.md` | Prompt para títulos optimizados |
| `thumbnail-dalle.md` | Prompt para thumbnails |
| `seo-keywords.md` | Keywords por playlist |
| `playlists.md` | Estructura de playlists |
| `env.example` | Variables de entorno |

## Flujo de producción
```
n8n trigger
  → Groq: guión
  → Groq: título + descripción + tags
  → Google Colab: audio XTTS v2
  → Google Colab: vídeo LatentSync (lip-sync)
  → FFmpeg: monta vídeo final
  → DALL-E 3: thumbnail
  → YouTube API: sube con metadata
  → Telegram: notificación
```
