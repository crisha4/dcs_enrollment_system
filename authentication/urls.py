from django.urls import path
from . import views
urlpatterns = [
    path("", views.land, name="authentication-land"),
    # path("login/", views.login, name="authentication-login"),
    # path("home/", views.home, name="home"),
]