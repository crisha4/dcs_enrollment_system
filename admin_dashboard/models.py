from django.db import models
from django.contrib.auth.models import User

class student(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=True)
    studentnumber = models.CharField(max_length=100, null=True)
    firstname = models.CharField(max_length=100, null=True)
    middlename = models.CharField(max_length=100, null=True)
    lastname = models.CharField(max_length=100, null=True)
    suffix = models.CharField(max_length=100, null=True)
    dateofbirth = models.DateField(null=True)
    gender = models.CharField(max_length=10, null=True)
    email = models.EmailField(null=True)
    contact = models.CharField(max_length=255, null=True)
    address = models.CharField(max_length=250, null=True)
    year = models.CharField(max_length=50, null=True)
    course = models.CharField(max_length=50, null=True)
    sectionyear = models.CharField(max_length=50, null=True)
    section = models.CharField(max_length=50, null=True)
    major = models.CharField(max_length=50, null=True)
    status = models.CharField(max_length=50, null=True)
    new_or_old = models.CharField(max_length=50, null=True)


    class Meta:
        db_table = 'students'

class Subject(models.Model):
    
    course_code = models.CharField(max_length=10, unique=True, null=True)
    course_title = models.CharField(max_length=100, null=True)
    year = models.IntegerField(choices=[
        (1, 'First Year'),
        (2, 'Second Year'),
        (3, 'Third Year'),
        (4, 'Fourth Year')
        ], null=True)
    semester = models.IntegerField(choices=[
        (1, 'First Semester'),
        (2, 'Second Semester')
        ], null=True)
    subject_units_lec = models.IntegerField(null=True)
    subject_units_lab = models.IntegerField(null=True)
    prerequisite = models.ForeignKey(
        'self',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='dependent_subjects'
    )

    def __str__(self):
        return self.course_code
    
class Instructor(models.Model):
    name = models.CharField(max_length=100, null=True)
    gender = models.CharField(max_length=1, choices=[('M', 'Male'),('F', 'Female'),('O', 'Other')], null=True)
    email = models.EmailField(unique=True, null=True)
    contact = models.CharField(max_length=15, null=True)
    address = models.TextField(null=True)

    def __str__(self):
        return self.name