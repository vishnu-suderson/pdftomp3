from celery import shared_task
from django.shortcuts import redirect
from .models import Profile, PDFFile,MP3File
import fitz  # PyMuPDF
import edge_tts
import os
import asyncio
from langdetect import detect
from celery import Celery

app = Celery('pdftomp3')
app.config_from_object('celery_config')



LANGUAGE_VOICE_MAP = {
    "en": {"male": "en-US-GuyNeural", "female": "en-US-JennyNeural"},
    "es": {"male": "es-ES-AlvaroNeural", "female": "es-ES-ElviraNeural"},
    "fr": {"male": "fr-FR-HenriNeural", "female": "fr-FR-DeniseNeural"},
    "de": {"male": "de-DE-KlausNeural", "female": "de-DE-AmalaNeural"},
    "it": {"male": "it-IT-DiegoNeural", "female": "it-IT-ElsaNeural"},
    "hi": {"male": "hi-IN-MadhurNeural", "female": "hi-IN-SwaraNeural"},
    "zh-cn": {"male": "zh-CN-YunxiNeural", "female": "zh-CN-XiaoxiaoNeural"},
    "ja": {"male": "ja-JP-KeitaNeural", "female": "ja-JP-NanamiNeural"},
    "ko": {"male": "ko-KR-InJoonNeural", "female": "ko-KR-SunHiNeural"},
    "ru": {"male": "ru-RU-DmitryNeural", "female": "ru-RU-SvetlanaNeural"},
    "ta": {"male": "ta-IN-ValluvarNeural", "female": "ta-IN-PallaviNeural"},  # Tamil Voices
}


def detect_language(text):
    try:
        return detect(text)  # Detect the language from the extracted text
    except:
        return "en"  # Default to English if detection fails

def select_voice(text, preferred_gender="male"):
    detected_lang = detect_language(text)  
    voice_options = LANGUAGE_VOICE_MAP.get(detected_lang, LANGUAGE_VOICE_MAP["en"])
    return voice_options.get(preferred_gender, "en-US-GuyNeural")  # Default to Male (US)

#@shared_task
@app.task 
def convert_pdf_to_mp3_task(preferred_gender, pdf_path, title, profile):
    async def pdf_to_mp3(pdf_file, output_file, voice):
        try:
            doc = fitz.open(pdf_file)
            text = " ".join(page.get_text() for page in doc)  # Extract text from PDF
            doc.close()

            detected_voice = select_voice(text, preferred_gender)  # Get appropriate voice
            communicate = edge_tts.Communicate(text, detected_voice)
            await communicate.save(output_file)
            print(f"MP3 file saved as: {output_file}")
        except Exception as e:
            print(f"An error occurred: {e}")

    # Set up output directory
    output_dir = "media/mp3s"
    os.makedirs(output_dir, exist_ok=True)

    # Format filename based on gender
    gender_label = "male" if preferred_gender == "male" else "female"
    sanitized_title = title.replace(" ", "_")
    output_file = os.path.join(output_dir, f"{sanitized_title}_[{gender_label}].mp3")

    # Run the conversion task asynchronously
    loop = asyncio.get_event_loop()
    loop.run_until_complete(pdf_to_mp3(pdf_path, output_file, preferred_gender))

    # Save to the database
    user = Profile.objects.get(id=profile)
    mp3_file = MP3File(mp3_file=f"mp3s/{sanitized_title}_[{gender_label}].mp3", title=title, user=user)
    mp3_file.save()

    return {"status": "success", "id": mp3_file.id, "user": profile}