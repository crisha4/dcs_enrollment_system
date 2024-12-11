from django.shortcuts import render
def land(request):
    return render(request, "authentication/land.html",{})

def login(request):
    return render(request, "authentication/login.html",{})

def login_student(request):
    return render(request, "authentication/login_student.html",{})

def home(request):
    return render(request, "admin_dashboard/index.html", {})

def student_home(request):
    return render(request, "student_dashboard/index.html", {})

def logout(request):
    pass