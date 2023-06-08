from pydantic import BaseModel, constr
from fastapi import FastAPI
from audio import gen_audio
from scipy.io.wavfile import write as write_wav
from bark import SAMPLE_RATE

app = FastAPI()

class Prompt(BaseModel):
    text:constr(strip_whitespace=True)

@app.post("/generate_audio")
def text_to_audio(prompt:Prompt):
    print(prompt)
    print(type(prompt))
    print(hasattr(prompt, "text"))
    print(prompt.text)
    text_prompt = prompt.text
    audio_array = gen_audio(text_prompt)
    return {"audio_array" : audio_array.tolist()}
