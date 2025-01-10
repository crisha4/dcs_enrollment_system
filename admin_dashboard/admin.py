from django.contrib import admin
from .models import student, Subject, Instructor, Program, Checklist, ChecklistItem

# Register your models here.
admin.site.register(student)
admin.site.register(Subject)
admin.site.register(Instructor)
admin.site.register(Program)
admin.site.register(Checklist)
admin.site.register(ChecklistItem)
