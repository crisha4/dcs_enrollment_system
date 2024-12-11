from django.urls import path
from . import views

urlpatterns = [
    path("student_profile/", views.student_profile, name="student-dashboard-profile"),
    path("student_status/", views.student_status, name="student-dashboard-status"),
    path("student_cor/", views.student_cor, name="student-dashboard-cor"),
]
