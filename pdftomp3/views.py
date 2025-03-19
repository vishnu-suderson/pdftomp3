from django.shortcuts import render,redirect,get_object_or_404
from django.http import HttpResponse, Http404
from .forms import Registrationform,ProfileUpdateForm
from django.contrib.auth import authenticate,login as auth,logout
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.utils.timezone import now
from .models import UserActivity

from django.urls import reverse_lazy

from django.http import JsonResponse

from django.contrib.auth.models import User

from django.core.paginator import Paginator
from django.http import JsonResponse
from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives

import os

from .models import PDFFile, Profile
from .forms import PDFUploadForm
from django.core.exceptions import ObjectDoesNotExist
from .models import PDFFile,Profile,MP3File

import random
from django.core.mail import send_mail
from django.utils.timezone import now, timedelta
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password


from django.contrib import messages
from django.utils.timezone import now

from django.db import models

def send_otp_email(receiver_email, otp, username,template):
    subject = "Your OTP Code"
    html_content = render_to_string(f"pdftomp3/{template}", {"otp": otp, "Username": username})  # Render HTML
    text_content = strip_tags(html_content)  # Fallback plain text

    email = EmailMultiAlternatives(
        subject, text_content, "your_email@gmail.com", [receiver_email]
    )
    email.attach_alternative(html_content, "text/html")  # Attach HTML version
    email.send()
# Create your views here.
def index(request):
    return render(request, 'pdftomp3/index.html')

def login(request):
    if(request.POST):
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            auth(request,user)
            UserActivity.objects.create(user=user, start_time=now())
            return redirect(reverse_lazy("Dashboard"))
        else:
            return render(request,'pdftomp3/login.html',{"error":"Invalid username or password"})
    return render(request,'pdftomp3/login.html')


def signin(request):
    form=Registrationform()
    if(request.method=="POST"):
        form=Registrationform(request.POST)
        print(form.is_valid())
        if(form.is_valid()):
            otp = random.randint(1000, 9999)
            
            send_otp_email(form.cleaned_data['email'],otp,form.cleaned_data['username'],"email_template.html")
            print(form.cleaned_data)
            request.session['form_data'] = form.cleaned_data
            # Save the OTP to session or database for verification
            request.session['otp'] = otp
            return redirect(reverse_lazy('verify'))
    else:
        print(form.errors) 
    return render(request,'pdftomp3/sign.html',{"form":form})  

def sigin_verification(request):
    if request.method == "POST":
        otp1 = request.POST.get("otp1", "")
        otp2 = request.POST.get("otp2", "")
        otp3 = request.POST.get("otp3", "")
        otp4 = request.POST.get("otp4", "")
        
        # Combine the OTP parts
        entered_otp = otp1 + otp2 + otp3 + otp4
        saved_otp = request.session.get('otp')
        print("enterned otp",entered_otp,"/n saved_otp:",saved_otp)
        if str(entered_otp) == str(saved_otp):
            print("same")
            form_data = request.session.get('form_data')
            print(form_data)
            if form_data:
                form = Registrationform(form_data)
                if form.is_valid():
                    form.save()  # Save the form data to the database
                    # Clear the session data
                    del request.session['form_data']
                    del request.session['otp']
                    return redirect(reverse_lazy("Login"))
        else:
            print(request.session.get('otp'))
            return render(request,'pdftomp3/sigin_verification.html',{'error': 'Invalid OTP'})
    else:
        return render(request, 'pdftomp3/sigin_verification.html')

@login_required
def dashboard(request):
    profile = Profile.objects.get( user=request.user)
    pdf=profile.pdfs.all().order_by('date')[:4] 
    mp3_files=profile.mp3s.all().order_by('date')[:4] 
    total_pdfs = profile.pdfs.count()
    total_mp3s = profile.mp3s.count()
    total_files = total_pdfs + total_mp3s
    total_time = UserActivity.objects.aggregate(
     total_time=models.Sum(models.F('end_time') - models.F('start_time'))
    )['total_time']

    # Convert to hours and minutes
    total_hours = total_time.total_seconds() // 3600 if total_time else 0
    total_minutes = (total_time.total_seconds() % 3600) // 60 if total_time else 0
    return render(request, 'pdftomp3/dashboard.html',{'tab':'Dashboard',"pdf":pdf,"mp3_files":mp3_files,"profile":profile, 'total_files': total_files,
        'total_mp3s': total_mp3s,
        'total_pdfs': total_pdfs,
        'total_hours': int(total_hours),
        'total_minutes': int(total_minutes),})

@login_required
def single_upload(request):
    if request.method == 'POST':
        form = PDFUploadForm(request.POST, request.FILES)
        if form.is_valid():
            pdf_file = form.save(commit=False)
            profile = get_object_or_404(Profile, user=request.user)
            pdf_file.user = profile
            pdf_file.title = pdf_file.pdf_file.name
            pdf_file.save()
            return redirect('preview_pdf', pdf_id=pdf_file.id)
        else:
            # Handle form errors
            return render(request, 'pdftomp3/upload.html', {
                'tab': 'single_upload',
                'form': form,
                'error': form.errors,  # Pass errors to the template
                'profile': profile,
            })
    else:
        form = PDFUploadForm()
    return render(request, 'pdftomp3/upload.html', {
        'tab': 'single_upload',
        'form': form,
        'profile': Profile.objects.get(user=request.user),
    })


@login_required
def playtime(request, id):
    print(request.user)
    profile = Profile.objects.get(user=request.user)
    mp3all = profile.mp3s.all()
    mp3 = get_object_or_404(profile.mp3s, id=id)  # Fetch the currently playing song
    
    # Get the index of the current song in the list
    mp3_list = list(mp3all)
    current_index = mp3_list.index(mp3) if mp3 in mp3_list else 0

    return render(request, 'pdftomp3/playtime.html', {
        'tab': 'Play',
        'mp3fileall': mp3all,
        'mp3file': mp3,
        'current_index': current_index,
        'total_songs': len(mp3_list),
        'profile': profile,
    })


@login_required
def logout_view(request):
    profile=Profile.objects.get(user=request.user)
    if request.method=="POST":
        UserActivity.objects.create(user=request.user, end_time=now() )
        logout(request)
        return redirect(reverse_lazy("index"))
    return render(request,'pdftomp3/logout.html',{"username":profile.username})



@login_required
def edit_profile(request):
    profile = Profile.objects.get(user=request.user)

    if request.method == 'POST':
        form = ProfileUpdateForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            return redirect('Profile')  # Redirect to the profile page after saving

    else:
        form = ProfileUpdateForm(instance=profile)

    return render(request, 'pdftomp3/profile_form.html', {'form': form,"tab":"Users","profile":profile})


@login_required
def settings_view(request):
    """ Renders the settings page with user profile details. """
    user_profile = Profile.objects.get(user=request.user)
    return render(request, 'pdftomp3/settings.html', {'profile': user_profile,"tab":"Menu"})


def send_otp(request):
    if request.method == "POST":
        # Get the receiver's email from the form input or user model
        receiver_email = request.POST.get('email')  # Example: from an input field named 'email'
            
        try:
            users = User.objects.filter(email=receiver_email)
            print(users)
            otp = random.randint(1000, 9999)

            # Send OTP via email
            send_otp_email(receiver_email,otp,users.first().username,"forgot_template.html")

            # Save the OTP to session or database for verification
            request.session['otp'] = otp
            request.session['receiver_email'] = receiver_email
            return redirect('verify_otp')
        except User.DoesNotExist:
            return render(request, 'pdftomp3/send_otp.html', {'error': 'User Dont have account'})
    return render(request, 'pdftomp3/send_otp.html')

@login_required
def deleteProfile(request):
    print(request.method)
    profile=Profile.objects.get(user=request.user)
    if request.method=="POST":
        profile.delete()
        return redirect('index')
    return render(request,'pdftomp3/Delete.html',{"profile":profile.name})


def verify_otp(request):
    if request.method == "POST":
        otp1 = request.POST.get("otp1", "")
        otp2 = request.POST.get("otp2", "")
        otp3 = request.POST.get("otp3", "")
        otp4 = request.POST.get("otp4", "")
        
        # Combine the OTP parts
        entered_otp = otp1 + otp2 + otp3 + otp4
        saved_otp = request.session.get('otp')
        receiver_email = request.session.get('receiver_email')
        if str(entered_otp) == str(saved_otp):
            # OTP matches
            return redirect('reset_password')
        else:
            # OTP does not match
            return render(request, 'pdftomp3/verify_otp.html', {'error': 'Invalid OTP'})

    return render(request, 'pdftomp3/verify_otp.html')

def reset_password(request):
    if request.method == 'POST':
        print("POST request received")
        receiver_email = request.session.get('receiver_email')
        new_password = request.POST.get('new_password')
        confirm_password = request.POST.get('confirm_password')
        print(f"Receiver Email: {receiver_email}")
        print(f"New Password: {new_password}")
        print(f"Confirm Password: {confirm_password}")

        # Validate email
        try:
            user = User.objects.get(email=receiver_email)
        except User.DoesNotExist:
            print("No user found with this email.")
            messages.error(request, "No user found with this email.")
            return render(request, 'pdftomp3/reset_password.html')

        # Check if passwords match
        if new_password != confirm_password:
            print("Passwords do not match.")
            messages.error(request, "Passwords do not match.")
            return render(request, 'pdftomp3/reset_password.html')

        # Update the user's password
        user.password = make_password(new_password)
        user.save()
        print("Password updated successfully.")
        messages.success(request, "Password updated successfully.")
        return render(request, 'pdftomp3/success.html')

    return render(request, 'pdftomp3/reset_password.html')




def profile(request):
   profile = get_object_or_404(Profile, user=request.user)

   mp3_files = MP3File.objects.filter(user=profile).order_by('id')
    # Total number of files converted
   total_files_converted = profile.pdfs.count()

   total_audio_duration = profile.mp3s.count()

    # Get the most recent conversion
   last_conversion = mp3_files.last()

   context = {
        'profile': profile,
        'total_files_converted': total_files_converted,
        'total_audio_duration': total_audio_duration,
        'last_conversion': last_conversion,
        'mp3_files': mp3_files[:5], 
         "tab":"Users", # Show last 5 conversions
    }

   return render(request, 'pdftomp3/profile.html', context)

def error_404_view(request,exception):
    return render(request, 'pdftomp3/404.html', status=404)

def error_500_view(request):
    return render(request, 'pdftomp3/500.html', status=500)

def about(request):
    return render(request, 'pdftomp3/about.html',{"tab":"About"})


def privacy(request):
    return render(request, 'pdftomp3/privacy.html',{"tab":"Privacy"})


def file_list(request):
    profile = get_object_or_404(Profile, user=request.user)
    pdf_files = PDFFile.objects.filter(user=profile)
    #pdf_files=Paginator(pdf_files, 4)
    paginator = Paginator(pdf_files, 4)  # Show 8 items per page
    page_number = request.GET.get('page', 1)  # Get current page number, default to 1
    page_obj = paginator.get_page(page_number)
    mp3_files = MP3File.objects.filter(user=profile).order_by('id')[:4] 
    return render(request, 'pdftomp3/file_list.html', {'pdf_files': page_obj, 'mp3_files': mp3_files ,"tab":"Files",'profile': profile})

def download_mp3(request, mp3_id):
    profile = get_object_or_404(Profile, user=request.user)
    mp3_file = get_object_or_404(MP3File, id=mp3_id, user=profile)
    file_path = mp3_file.mp3_file.path
    if os.path.exists(file_path):
        with open(file_path, 'rb') as fh:
            response = HttpResponse(fh.read(), content_type="audio/mpeg")
            response['Content -Disposition'] = f'attachment; filename={mp3_file.title}'
            return response
    else:
        raise Http404("MP3 file does not exist.")

def delete_mp3(request, mp3_id):
    if request.method == "DELETE":
        mp3_file = get_object_or_404(MP3File, id=mp3_id, user=request.user.profile)
        file_path = mp3_file.mp3_file.path
        mp3_file.delete()
        if os.path.exists(file_path):
            os.remove(file_path)
        return JsonResponse({"success": True})
    return JsonResponse({"success": False}, status=400)


def delete_pdf(request, pdf_id):
    if request.method == "DELETE":
        mp3_file = get_object_or_404(MP3File, id=pdf_id, user=request.user.profile)
        file_path = mp3_file.pdf_file.path
        mp3_file.delete()
        if os.path.exists(file_path):
            os.remove(file_path)
        return JsonResponse({"success": True})
    return JsonResponse({"success": False}, status=400)
 
from django.shortcuts import get_object_or_404, render, redirect
from .models import PDFFile, Profile
from .tasks import convert_pdf_to_mp3_task
from celery.result import AsyncResult

def preview_pdf(request, pdf_id):
    profile = get_object_or_404(Profile, user=request.user)
    pdf_file = get_object_or_404(PDFFile, id=pdf_id, user=profile)
    return render(request, 'pdftomp3/preview.html', {'pdf_file': pdf_file,"tab":"Files",'profile': profile})

def Voicetype(request, pdf_id):
    profile = get_object_or_404(Profile, user=request.user)
    pdf_file = get_object_or_404(PDFFile, id=pdf_id, user=profile)

    if request.method == 'POST':
            # Get the file path and title
            voice=request.POST.get("voiceType")
            print(voice)
            pdf_path = pdf_file.pdf_file.path  # Get the absolute path to the file
            title = pdf_file.title.replace(".pdf","")  # Assuming `PDFFile` has a `title` field
            try:
                # Pass the path and IDs to the Celery task
                task=convert_pdf_to_mp3_task.delay(voice,pdf_path, title,profile.id)
                request.session['task_id']=task.id
                return redirect('progress_view')  # Redirect to a progress page or file list
            except Exception as e:
                print("error",e)
                return render(request, 'pdftomp3/voice_type.html', {'pdf_file': pdf_file, 'tab': 'Files','profile': profile, 'error': str(e)}) 
    return render(request, 'pdftomp3/voice_type.html', {'pdf_file': pdf_file,  'tab': 'Files', 'profile': profile})

from django.http import JsonResponse
from celery.result import AsyncResult
from django.core.paginator import Paginator

def audio_files_view(request):
    search_query = request.GET.get('search', '')  # Get the search query from the request
    print(f"Search query: {search_query}")
    profile = Profile.objects.get(user=request.user)
    
    if search_query:
        mp3_files = profile.mp3s.filter(title__icontains=search_query).order_by('id')
    else:
        mp3_files = profile.mp3s.all().order_by('id')

    # Set up pagination
    paginator = Paginator(mp3_files, 8)  # Show 8 items per page
    page_number = request.GET.get('page', 1)  # Get current page number, default to 1
    page_obj = paginator.get_page(page_number)

    # Check if it's an AJAX request
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        html = render_to_string(
            'pdftomp3/partials/mp3files.html', 
            {'mp3_files': page_obj}
        )
        return JsonResponse({'html': html})

    context = {
        'mp3_files': page_obj,
        'has_previous': page_obj.has_previous(),
        'has_next': page_obj.has_next(),
        'previous_page_number': page_obj.previous_page_number() if page_obj.has_previous() else None,
        'next_page_number': page_obj.next_page_number() if page_obj.has_next() else None,
        'current_page': page_obj.number,
        'total_pages': paginator.num_pages,
        'tab': 'Play',
        'profile': profile,
    }
    return render(request, 'pdftomp3/mp3files.html', context)






def progress_view(request):
    return render(request, 'pdftomp3/progress.html')

def progress(request):
    # Get the task_id from the session
    task_id = request.session.get('task_id')
    if not task_id:
        return JsonResponse({"status": "error", "message": "No task ID found in session."}, status=400)

    # Check the task status using Celery's AsyncResult
    task_result = AsyncResult(task_id)
    status = task_result.status
    result = task_result.result if task_result.ready() else None

    print(f"Task ID: {task_id}, Status: {status}, Result: {result}")

    # Handle task status
    if status == "SUCCESS":
        # Optionally clear the session task_id
        request.session.pop('task_id', None)
        print(result['id'])
        return JsonResponse({"status": "SUCCESS", "redirect_url": f"/play/{result['id']}/"})
    elif status == "FAILURE":
        return JsonResponse({"status": "FAILURE", "message": str(task_result.result)})
    else:
        # For PENDING or STARTED status
        return JsonResponse({"status": status})



def pdf_files_view(request):
    search_query = request.GET.get('search', '')  # Get the search query from the request
    print(f"Search query: {search_query}")
    profile = Profile.objects.get(user=request.user)
    
    if search_query:
        pdf_files = profile.pdfs.filter(title__icontains=search_query).order_by('id')
    else:
        pdf_files = profile.pdfs.all().order_by('id')

    # Set up pagination
    paginator = Paginator(pdf_files, 8)  # Show 8 items per page
    page_number = request.GET.get('page', 1)  # Get current page number, default to 1
    page_obj = paginator.get_page(page_number)

    # Check if it's an AJAX request
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        html = render_to_string(
            'pdftomp3/partials/pdffile.html', 
            {'pdf_files': page_obj}
        )
        return JsonResponse({'html': html})

    context = {
        'pdf_files': page_obj,
        'has_previous': page_obj.has_previous(),
        'has_next': page_obj.has_next(),
        'previous_page_number': page_obj.previous_page_number() if page_obj.has_previous() else None,
        'next_page_number': page_obj.next_page_number() if page_obj.has_next() else None,
        'current_page': page_obj.number,
        'total_pages': paginator.num_pages,
        'tab': 'Files',
        'profile': profile,
    }
    return render(request, 'pdftomp3/pdffile.html', context)

