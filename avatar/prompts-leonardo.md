# Prompts Leonardo.ai — Juan Fit / JOTATIGER.FIT

## Configuración recomendada en Leonardo.ai
- **Modelo:** Leonardo Kino XL o AlbedoBase XL
- **Dimensiones:** 832x1216px (retrato vertical)
- **Activa:** PhotoReal v2
- **Guidance Scale:** 7
- **Genera:** 4 variaciones y elige la mejor

---

## NEGATIVE PROMPT (usar en TODOS los prompts)
```
cartoon, anime, illustration, drawing, painting, blurry, deformed, bad anatomy,
extra limbs, ugly face, watermark, text, logo, beard, body hair, old, wrinkles,
overweight, tattoo on face, glasses, hat, cap, sunglasses, nsfw
```

---

## PROMPT BASE — Fondo neutro (para lip-sync con LatentSync)
> Genera este PRIMERO. Es el avatar base para todos los vídeos.
> Guarda como: `assets/juan-fit-base.jpg`

```
Photorealistic full body portrait of a fit athletic Spanish man, 32 years old,
1.80m tall, tanned Mediterranean skin, short dark brown hair, striking blue eyes,
sharp defined jawline, clean shaven no beard no body hair, friendly relaxed expression,
mouth very slightly open, looking directly at camera, approachable and charismatic,
wearing a fitted short sleeve blue athletic t-shirt and blue sport shorts,
white sport sneakers, short blue ankle socks,
colorful detailed dragon tattoo on left forearm,
colorful detailed dragon tattoo from right shoulder down to elbow,
colorful detailed fairy tattoo on right forearm extending to wrist,
small lizard tattoo on right side of neck,
neutral dark background, soft professional studio lighting, subtle rim light,
8K resolution, photorealistic, sharp focus, professional fitness photography
```

---

## FONDO A — Gym moderno
> Para playlists: **Músculo / Consejos Directos**
> Guarda como: `assets/juan-fit-gym.jpg`

```
Photorealistic full body portrait of a fit athletic Spanish man, 32 years old,
1.80m tall, tanned Mediterranean skin, short dark brown hair, striking blue eyes,
sharp defined jawline, clean shaven, confident relaxed expression, mouth slightly open,
looking directly at camera,
wearing a fitted short sleeve blue athletic t-shirt and blue sport shorts,
white sport sneakers, short blue ankle socks,
colorful detailed dragon tattoo on left forearm,
colorful detailed dragon tattoo from right shoulder down to elbow,
colorful detailed fairy tattoo on right forearm extending to wrist,
small lizard tattoo on right side of neck,
modern professional gym background blurred bokeh, dumbbells barbells weight racks visible,
dramatic cinematic lighting, depth of field,
8K resolution, photorealistic, professional fitness photography
```

---

## FONDO B — Estudio oscuro con luz dramática
> Para playlists: **Pérdida de Grasa / Complementos**
> Guarda como: `assets/juan-fit-estudio.jpg`

```
Photorealistic full body portrait of a fit athletic Spanish man, 32 years old,
1.80m tall, tanned Mediterranean skin, short dark brown hair, striking blue eyes,
sharp defined jawline, clean shaven, serious intense expression, mouth slightly open,
looking directly at camera,
wearing a fitted short sleeve blue athletic t-shirt and blue sport shorts,
white sport sneakers, short blue ankle socks,
colorful detailed dragon tattoo on left forearm,
colorful detailed dragon tattoo from right shoulder down to elbow,
colorful detailed fairy tattoo on right forearm extending to wrist,
small lizard tattoo on right side of neck,
dark studio background black to dark emerald green gradient,
strong dramatic side rim lighting, deep cinematic shadows,
8K resolution, photorealistic, editorial photography
```

---

## FONDO C — Exterior urbano
> Para playlists: **Motivación**
> Guarda como: `assets/juan-fit-urbano.jpg`

```
Photorealistic full body portrait of a fit athletic Spanish man, 32 years old,
1.80m tall, tanned Mediterranean skin, short dark brown hair, striking blue eyes,
sharp defined jawline, clean shaven, motivated determined expression, mouth slightly open,
looking directly at camera with intensity,
wearing a fitted short sleeve blue athletic t-shirt and blue sport shorts,
white sport sneakers, short blue ankle socks,
colorful detailed dragon tattoo on left forearm,
colorful detailed dragon tattoo from right shoulder down to elbow,
colorful detailed fairy tattoo on right forearm extending to wrist,
small lizard tattoo on right side of neck,
urban city street background blurred bokeh, golden hour warm sunlight,
cinematic depth of field, lifestyle editorial photography,
8K resolution, photorealistic
```

---

## FONDO D — Cocina moderna
> Para playlists: **Comida / Alternativas Saludables**
> Guarda como: `assets/juan-fit-cocina.jpg`

```
Photorealistic full body portrait of a fit athletic Spanish man, 32 years old,
1.80m tall, tanned Mediterranean skin, short dark brown hair, striking blue eyes,
sharp defined jawline, clean shaven, friendly approachable slight smile, mouth slightly open,
looking directly at camera,
wearing a fitted short sleeve blue athletic t-shirt and blue sport shorts,
white sport sneakers, short blue ankle socks,
colorful detailed dragon tattoo on left forearm,
colorful detailed dragon tattoo from right shoulder down to elbow,
colorful detailed fairy tattoo on right forearm extending to wrist,
small lizard tattoo on right side of neck,
modern clean bright kitchen background blurred bokeh, natural daylight warm tones,
lifestyle photography depth of field,
8K resolution, photorealistic
```

---

## FONDO E — Naturaleza exterior
> Para playlists: **Salud General / Longevidad**
> Guarda como: `assets/juan-fit-naturaleza.jpg`

```
Photorealistic full body portrait of a fit athletic Spanish man, 32 years old,
1.80m tall, tanned Mediterranean skin, short dark brown hair, striking blue eyes,
sharp defined jawline, clean shaven, calm peaceful serene expression, mouth slightly open,
looking directly at camera,
wearing a fitted short sleeve blue athletic t-shirt and blue sport shorts,
white sport sneakers, short blue ankle socks,
colorful detailed dragon tattoo on left forearm,
colorful detailed dragon tattoo from right shoulder down to elbow,
colorful detailed fairy tattoo on right forearm extending to wrist,
small lizard tattoo on right side of neck,
lush green nature park forest background blurred bokeh,
soft natural golden sunlight, fresh wellness feel,
8K resolution, photorealistic, lifestyle wellness photography
```

---

## Orden de generación recomendado
1. **PROMPT BASE** primero (fondo neutro) → es el que va a LatentSync
2. Fondos A → B → C → D → E
3. Guarda todas en `assets/` con los nombres indicados
4. Sube las imágenes al repo: `git add assets/ && git commit -m "feat: añadir avatares Juan Fit"`

---

## Qué buscar al elegir la imagen correcta
- Cara bien centrada y visible
- Boca ligeramente abierta (no cerrada del todo, no sonriendo exagerado)
- Tatuajes visibles en los brazos
- Sin oclusiones en la cara (sin manos tapando, sin sombras excesivas)
- Expresión natural, no forzada
