from django.urls import path
from . import views

urlpatterns = [
    path('',views.index, name="index"),
    path('Login',views.login, name="Login"),
    path('Logout',views.logout_view, name="Logout"),
    path('Sigin',views.signin, name="Sigin"),
    path('Dashboard',views.dashboard, name="Dashboard"),
    path('upload',views.single_upload, name="single_upload"),
    path('play/<int:id>/',views.playtime, name="playtime"),
    path('mp3files/',views.audio_files_view, name="mp3files"),


 path('progress', views.progress, name='progress'),

 path('progressing', views.progress_view, name='progress_view'),

  path('preview/<int:pdf_id>/', views.preview_pdf, name='preview_pdf'),
  path('Voice/<int:pdf_id>/', views.Voicetype, name='voice_type'),
    path('files/', views.file_list, name='file_list'),
   path('download/<int:mp3_id>/', views.download_mp3, name='download_mp3'),

   path('edit',views.profile,name="edit"),


    path('send-otp/', views.send_otp, name='send_otp'),
    path('verify/', views.sigin_verification, name='verify'),
    path('verify-otp/', views.verify_otp, name='verify_otp'),

    path('reset-password/', views.reset_password, name='reset_password'),
]

