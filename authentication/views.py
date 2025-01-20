from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

def land(request):
    return render(request, "authentication/land.html",{})

@login_required
def redirect_view(request):
    if request.user.is_superuser or request.user.is_staff:
        return redirect('home')
    else:
        return redirect('student-home')