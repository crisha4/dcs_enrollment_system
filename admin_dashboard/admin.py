from django.contrib import admin
from .models import student, Subject, Instructor

# Register your models here.
admin.site.register(student)
admin.site.register(Subject)
admin.site.register(Instructor)
