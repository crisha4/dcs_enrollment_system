from django.urls import path
from . import views

urlpatterns = [
    path("home/", views.student_home, name="student-home"), 
    path("profile/", views.student_profile, name="student-profile"),
    path("status/", views.student_status, name="student-status"),
    path("cor/", views.student_cor, name="student-cor"),
]
