````cmd
env\scripts\activate.bat
````
````cmd
celery -A celery_config worker --loglevel=info --pool=solo
````