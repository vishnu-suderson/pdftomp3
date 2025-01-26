
````cmd
env\scripts\activate.bat
````
````
celery -A celery_config worker --loglevel=info --pool=solo
````