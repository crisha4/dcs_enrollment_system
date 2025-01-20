from django.test import TestCase
from django.urls import reverse
from django.contrib.auth.models import User

class AuthenticationViewsTest(TestCase):
  def setUp(self):
    self.superuser = User.objects.create_superuser(username='admin', password='admin123', email='admin@example.com')
    self.regular_user = User.objects.create_user(username='student', password='student123', email='student@example.com')

  def test_land_view(self):
    response = self.client.get(reverse('authentication-land'))
    self.assertEqual(response.status_code, 200)
    self.assertTemplateUsed(response, 'authentication/land.html')

  def test_redirect_view_for_superuser(self):
    self.client.login(username='admin', password='admin123')
    response = self.client.get(reverse('login_redirect'))
    self.assertRedirects(response, reverse('home'))

  def test_redirect_view_for_regular_user(self):
    self.client.login(username='student', password='student123')
    response = self.client.get(reverse('login_redirect'))
    self.assertRedirects(response, reverse('student-home'))

  def test_redirect_view_for_anonymous_user(self):
    response = self.client.get(reverse('login_redirect'))
    self.assertRedirects(response, f"{reverse('login')}?next={reverse('login_redirect')}")
