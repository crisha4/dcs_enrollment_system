from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from admin_dashboard.models import student

def student_home(request):
    try:
        student_profile = student.objects.get(user=request.user)
    except student.DoesNotExist:
        student_profile = None

    return render(request, "student_dashboard/index.html", {'student': student_profile})

@login_required
def student_profile(request):
    try:
        student_profile = student.objects.get(user=request.user)
    except student.DoesNotExist:
        student_profile = None
    return render(request, "student_dashboard/profile.html",{'student': student_profile})

def student_status(request):
    return render(request, "student_dashboard/status.html",{})

def student_cor(request):
    return render(request, "student_dashboard/view_cor.html",{})
