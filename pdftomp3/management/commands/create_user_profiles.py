# your_app/management/commands/create_user_profiles.py
from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from ...models import Profile

class Command(BaseCommand):
    help = 'Create UserProfile for all existing users'

    def handle(self, *args, **kwargs):
        for user in User.objects.all():
            Profile.objects.get_or_create(user=user,name=user.first_name, username=user.username, email=user.email, passwords=user.password, mobile_phone='xxxx', POSITION='xxxx', profile_pic='profile_pics/default.jpg')
        self.stdout.write(self.style.SUCCESS('User  profiles created for all existing users.'))