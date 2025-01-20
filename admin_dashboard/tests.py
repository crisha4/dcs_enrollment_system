from django.test import TestCase, Client
from django.urls import reverse
from .models import student, Subject, Instructor, Program
from django.contrib.auth.models import User
from datetime import datetime

class AdminDashboardTests(TestCase):
    def setUp(self):
        # Create test user
        self.user = User.objects.create_user(
            username='testuser', 
            password='testpassword',
            is_staff=True
        )
        self.client = Client()
        self.client.login(username='testuser', password='testpassword')

        # Create test data
        self.student = student.objects.create(
            firstname='John',
            lastname='Doe',
            middlename='Smith',
            dateofbirth='2000-01-01',
            gender='Male',
            contact='1234567890',
            email='johndoe@example.com',
            address='123 Main St',
            year=1,
            sectionyear='2025',
            section='A',
            course='BSCS',
            major='None',
            status='Active',
            studentnumber='20250001',
        )
        self.program = Program.objects.create(
            name="BS Computer Science",
            full="Bachelor of Science in Computer Science",
        )

        # Create a Subject instance
        self.subject = Subject.objects.create(
            course_code='CS101',
            course_title='Introduction to Computer Science',
            year=1,
            semester=1,
            subject_units_lec=3,
            subject_units_lab=1,
            program_id=self.program.id,  # Pass the Program instance
        )
        self.instructor = Instructor.objects.create(
            name='Jane Doe',
            gender='F',
            email='janedoe@example.com',
            contact='9876543210',
            address='456 Elm St',
        )

    def test_home_view(self):
        response = self.client.get(reverse('home'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'admin_dashboard/index.html')
        self.assertContains(response, self.student.firstname)

    def test_admin_profile_view(self):
        response = self.client.get(reverse('admin_profile'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'admin_dashboard/profile.html')

    def test_admin_masterlist_view(self):
        response = self.client.get(reverse('admin_masterlist'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'admin_dashboard/masterlist.html')
        self.assertContains(response, self.student.studentnumber)

    def test_fetch_student_checklist(self):
        response = self.client.get(reverse('fetch_student_checklist'), {'student_number': self.student.studentnumber})
        self.assertEqual(response.status_code, 200)
        self.assertJSONEqual(
            str(response.content, encoding='utf8'),
            {
                "firstname": self.student.firstname,
                "middlename": self.student.middlename,
                "lastname": self.student.lastname,
                "suffix": self.student.suffix,
                "year": self.student.year,
                "course": self.student.course,
                "current_date": datetime.now().strftime("%B %d, %Y"),
            }
        )

    def test_add_student_view(self):
        response = self.client.get(reverse('add_student'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'admin_dashboard/add_student.html')

    def test_save_subject_view(self):
        program = Program.objects.create(name="Sample Program")
        data = {
            'course_code': 'CS102',
            'course_title': 'Advanced Programming',
            'year': 1,
            'semester': 2,
            'subject_units_lec': 3,
            'subject_units_lab': 1,
            "program_id": program.id,
        }
        response = self.client.post(reverse('save_subject'), data)
        self.assertEqual(response.status_code, 200)
        self.assertTrue(Subject.objects.filter(course_code='CS102').exists())

    def test_delete_subject_view(self):
        response = self.client.get(reverse('delete_subject', args=[self.subject.id]))
        self.assertEqual(response.status_code, 302)  # Should redirect
        self.assertFalse(Subject.objects.filter(id=self.subject.id).exists())

    def test_save_instructor_view(self):
        data = {
            'instructor_name': 'New Instructor',
            'gender': 'Male',
            'email': 'newinstructor@example.com',
            'contact': '1234567899',
            'address': '789 Pine St',
        }
        response = self.client.post(reverse('save_instructor'), data)
        self.assertEqual(response.status_code, 200)
        self.assertTrue(Instructor.objects.filter(email='newinstructor@example.com').exists())

    def test_delete_instructor_view(self):
        response = self.client.get(reverse('delete_instructor', args=[self.instructor.id]))
        self.assertEqual(response.status_code, 302)  # Should redirect
        self.assertFalse(Instructor.objects.filter(id=self.instructor.id).exists())
