from django.contrib import admin

# Register your models here.
from .models import User,Community,UserData

admin.site.register(User)
admin.site.register(Community)
admin.site.register(UserData)