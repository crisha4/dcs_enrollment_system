from django.urls import path
from . import views

urlpatterns = [
    path("home/", views.home, name="home"),
    path("admin_profile/", views.admin_profile, name="admin-dashboard-profile"),
    path("admin_masterlist/", views.admin_masterlist, name="admin-dashboard-masterlist"),
    path("admin_schedule/", views.admin_schedule, name="admin-dashboard-schedule"),
    path("admin_enrollment/", views.admin_enrollment, name="admin-dashboard-enrollment"),
    path("admin_checklist/", views.admin_checklist, name="admin-dashboard-checklist"),
    path("enroll_student/", views.enroll_student, name='enroll_student'),
]
