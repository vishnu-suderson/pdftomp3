from django.db import models
from django.contrib.auth.models import User

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    profile_pic = models.ImageField(upload_to='profile_pics', blank=True)
    name=models.CharField(max_length=225)
    username=models.CharField(max_length=225)
    passwords=models.CharField(max_length=225)
    mobile_phone=models.CharField(max_length=225,default="xxxx")
    email=models.EmailField(max_length=225,default="xxxx")
    POSITION = models.CharField(max_length=100,default="xxxx")

    def __str__(self):
        return self.user.username
 
class PDFFile(models.Model):
    pdf_file = models.FileField(upload_to='pdfs')
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(Profile, on_delete=models.CASCADE,related_name="pdfs")
    def __str__(self):
        return self.title
    
class MP3File(models.Model):
    mp3_file = models.FileField(upload_to='mp3s')
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(Profile, on_delete=models.CASCADE,related_name="mp3s")
    def __str__(self):
        return self.title


from django.db import models
from django.contrib.auth.models import User
from datetime import timedelta

class UserActivity(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    start_time = models.DateTimeField(auto_now_add=True)
    end_time = models.DateTimeField(null=True, blank=True)

    def duration(self):
        if self.end_time:
            return self.end_time - self.start_time
        return timedelta(0)  # No time spent if the session is still ongoing
