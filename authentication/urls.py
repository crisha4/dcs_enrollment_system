from django.urls import path
from . import views
urlpatterns = [
    path("", views.land, name="authentication-land"),
    path("login/", views.login, name="authentication-login"),
    path("login_student/", views.login_student, name="authentication-login-student"),
    path("home/", views.home, name="home"),
    path("student_home/", views.student_home, name="student-home"),
    
]