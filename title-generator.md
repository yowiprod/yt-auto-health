# Prompt: Generador de Títulos SEO — JOTATIGER.FIT

Usa este prompt en el nodo de Groq API en n8n.

```
Genera 5 variaciones de título para YouTube para el canal JOTATIGER.FIT.

Tema: {topic}
Playlist: {playlist}

REQUISITOS:
- Máximo 60 caracteres
- En español
- Incluye número cuando sea relevante (ej: "5 errores", "3 pasos")
- Usa palabras de impacto: Error / Nadie te dice / La verdad sobre /
  Por qué no / Deja de / Secreto / Lo que funciona de verdad
- Sin clickbait falso — el título debe reflejar el contenido real
- Lenguaje directo, no académico

FORMATO: Array JSON de strings únicamente, sin explicaciones.
["Título 1", "Título 2", "Título 3", "Título 4", "Título 5"]
```
