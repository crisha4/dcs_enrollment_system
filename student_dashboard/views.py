from django.shortcuts import render

def student_profile(request):
    return render(request, "student_dashboard/profile.html",{})
def student_status(request):
    return render(request, "student_dashboard/status.html",{})
def student_cor(request):
    return render(request, "student_dashboard/view_cor.html",{})
