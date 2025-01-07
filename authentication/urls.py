from django.urls import path
from . import views
urlpatterns = [
    path("", views.land, name="authentication-land"),
    path('redirect/', views.redirect_view, name='login_redirect'),
]