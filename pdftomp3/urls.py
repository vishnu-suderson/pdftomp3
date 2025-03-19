from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from . import views

urlpatterns = [
    path('',views.index, name="index"),
    path('Login',views.login, name="Login"),
    path('Logout',views.logout_view, name="Logout"),
    path('Sigin',views.signin, name="Sigup"),
    path('Dashboard',views.dashboard, name="Dashboard"),
    path('upload',views.single_upload, name="single_upload"),
    path('play/<int:id>/',views.playtime, name="playtime"),
    path('mp3files/',views.audio_files_view, name="mp3files"),

path('delete_pdf/<int:pdf_id>/', views.delete_pdf, name='delete_pdf'),

 path('progress', views.progress, name='progress'),

 path('progressing', views.progress_view, name='progress_view'),

  path('preview/<int:pdf_id>/', views.preview_pdf, name='preview_pdf'),
  path('Voice/<int:pdf_id>/', views.Voicetype, name='voice_type'),
  path('pdffiles/',views.pdf_files_view,name='pdffiles'),
    path('files/', views.file_list, name='file_list'),
   path('download/<int:mp3_id>/', views.download_mp3, name='download_mp3'),
   path('about/', views.about, name='about'),
   path('privacy/', views.privacy, name='privacy'),
   path('profile',views.profile,name="Profile"),
   path('settings/', views.settings_view, name='settings'),

    path('edit-profile/', views.edit_profile, name='edit_profile'),
    path("delete_mp3/<int:mp3_id>/", views.delete_mp3, name="delete_mp3"),
    path('send-otp/', views.send_otp, name='send_otp'),
    path('verify/', views.sigin_verification, name='verify'),
    path('verify-otp/', views.verify_otp, name='verify_otp'),
    path('profile-delete/',views.deleteProfile,name="delete"),
    path('reset-password/', views.reset_password, name='reset_password'),
]

