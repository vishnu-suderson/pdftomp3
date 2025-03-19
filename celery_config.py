# celery_config.py

import os
from celery import Celery


# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')  # Adjust 'Config.settings' to your actual settings module

app = Celery('pdftomp3')

# Load task modules from all registered Django app configs.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Automatically discover tasks in the 'pdftomp3' app
app.autodiscover_tasks(['pdftomp3'])

# Optional: You can define additional configurations here
app.conf.broker_url = 'redis://localhost:6379/0'  # Ensure this matches your Redis setup
broker_connection_retry_on_startup = True
broker_url = 'redis://localhost:6379/0'
result_backend = 'redis://localhost:6379/0'

from celery.schedules import crontab

app.conf.beat_schedule = {
    'say-hello-every-minute': {
        'task': 'myapp.tasks.say_hello',
        'schedule': crontab(minute='*'),
    },
}
