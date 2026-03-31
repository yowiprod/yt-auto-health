// Test ElevenLabs TTS
// Usage: node scripts/test-voice.js
require('dotenv').config();
const fs = require('fs');

async function test() {
  const res = await fetch(
    `https://api.elevenlabs.io/v1/text-to-speech/${process.env.ELEVENLABS_VOICE_ID}`,
    {
      method: "POST",
      headers: {
        "xi-api-key": process.env.ELEVENLABS_API_KEY,
        "Content-Type": "application/json",
        "Accept": "audio/mpeg"
      },
      body: JSON.stringify({
        text: "This is a test. Welcome to the channel.",
        model_id: "eleven_multilingual_v2",
        voice_settings: { stability: 0.5, similarity_boost: 0.75 }
      })
    }
  );
  fs.writeFileSync('test-audio.mp3', Buffer.from(await res.arrayBuffer()));
  console.log("Saved: test-audio.mp3");
}

test().catch(console.error);
