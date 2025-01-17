from django.urls import path
from . import views

urlpatterns = [
    path("admin_profile/", views.admin_profile, name="admin-dashboard-profile"),
    path("admin_masterlist/", views.admin_masterlist, name="admin-dashboard-masterlist"),
    path("admin_schedule/", views.admin_schedule, name="admin-dashboard-schedule"),
    path("admin_enrollment/", views.admin_enrollment, name="admin-dashboard-enrollment"),
    path("admin_checklist/", views.admin_checklist, name="admin-dashboard-checklist"),
    path("old_student_enrollment/", views.old_enrollee_view, name="old_student_enrollment"),
    path("new_student_enrollment/", views.new_enrollee_view, name="new_student_enrollment"),
    path("admin_new-or-old_enrollee/", views.new_or_old_enrollee_view, name="new_or_old_enrollee"),
    path("print_cor/", views.print_cor, name='print_cor'),
    path("edit_info/<str:student_number>", views.edit_info, name='edit_info'),
    path("process_cor/<str:student_number>", views.process_cor, name='process_cor'),
    path("update_info/<str:student_number>", views.update_info, name='update_info'),
    path("print_cor/<str:student_number>", views.print_cor, name='print_cor'),
    path("enroll_new_student/", views.enroll_new_student, name='enroll_new_student'),
    path("enroll_old_student/", views.enroll_old_student, name='enroll_old_student'),
    path("search_students/", views.search_students, name='search_students'),
]
