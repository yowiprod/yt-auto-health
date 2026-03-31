// Test XTTS v2 via Google Colab webhook
// Uso: node test-voice.js
// Requiere: Colab corriendo + COLAB_WEBHOOK_URL en .env
require('dotenv').config();
const fs = require('fs');

async function test() {
  const text = "Sin rollos, aquí va la verdad. La mayoría de la gente lleva años entrenando mal y nadie se lo ha explicado bien. Hoy te cuento exactamente qué falla y cómo arreglarlo.";

  console.log('Conectando con Google Colab XTTS v2...');

  const res = await fetch(`${process.env.COLAB_WEBHOOK_URL}${process.env.COLAB_TTS_ENDPOINT}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      text,
      language: 'es',
      speaker_wav: 'juan_fit_reference.wav'
    })
  });

  if (!res.ok) {
    console.error('Error:', res.status, await res.text());
    return;
  }

  const buffer = Buffer.from(await res.arrayBuffer());
  fs.writeFileSync('test-audio.wav', buffer);
  console.log('Audio guardado: test-audio.wav');
  console.log(`Tamaño: ${(buffer.length / 1024).toFixed(1)} KB`);
}

test().catch(console.error);
