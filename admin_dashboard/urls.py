from django.urls import path
from . import views

urlpatterns = [
    path("home/", views.home, name="home"),
    path("admin_profile/", views.admin_profile, name="admin-dashboard-profile"),
    path("admin_masterlist/", views.admin_masterlist, name="admin-dashboard-masterlist"),
    path("admin_schedule/", views.admin_schedule, name="admin-dashboard-schedule"),
    path("admin_enrollment/", views.admin_enrollment, name="admin-dashboard-enrollment"),
    path("admin_checklist/", views.admin_checklist, name="admin-dashboard-checklist"),
    path("print_cor/", views.print_cor, name='print_cor'),
    path("edit_info/<str:student_number>", views.edit_info, name='edit_info'),
    path("process_cor/<str:student_number>", views.process_cor, name='process_cor'),
    path("update_info/<str:student_number>", views.update_info, name='update_info'),
    path("print_cor/<str:student_number>", views.print_cor, name='print_cor'),
    path("enroll_student/", views.enroll_student, name='enroll_student'),
    path("search_students/", views.search_students, name='search_students'),

    path("configure/", views.admin_config, name="admin_config"),
    path('save_subject/', views.save_subject, name='save_subject'),
    path("delete_subject/<str:subject_id>/", views.delete_subject, name='delete_subject'),
    
]
