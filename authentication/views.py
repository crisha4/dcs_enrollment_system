from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.template.loader import get_template
from admin_dashboard import views

def land(request):
    return render(request, "authentication/land.html",{})
def login(request):
    return render(request, "authentication/login.html",{})
def home(request):
    template = loader.get_template('admin_dashboard/index.html')
    context = {
        'allstudents':views.allstudents,
        'number_of_students_enrolled':views.number_of_students_enrolled
    }

    return HttpResponse(template.render(context, request))

def logout(request):
    pass