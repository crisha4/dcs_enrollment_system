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

    def __str__(self):
        return f"{self.studentnumber} - {self.lastname}"

class Program(models.Model):
    name = models.CharField(max_length=50)
    full = models.CharField(max_length=100, blank=True)
    def __str__(self):
        return f"{self.name} - {self.full}"

class Subject(models.Model):
    course_code = models.CharField(max_length=10, null=True)
    course_title = models.CharField(max_length=100, null=True)
    program = models.ForeignKey(Program, on_delete=models.CASCADE, related_name="subjects", null=True, default=1)
    year = models.IntegerField(choices=[
        (1, 'First Year'),
        (2, 'Second Year'),
        (3, 'Third Year'),
        (4, 'Fourth Year')
        ], null=True)
    semester = models.IntegerField(choices=[
        (1, 'First Semester'),
        (2, 'Second Semester'),
        (3, 'Midyear'),
        ], null=True)
    subject_units_lec = models.IntegerField(null=True)
    subject_units_lab = models.IntegerField(null=True)
    prerequisite = models.ManyToManyField(
        'self',
        symmetrical=False,
        null=True,
        blank=True,
        related_name='dependent_subjects'
    )

    def __str__(self):
        return f"{self.program.name} - {self.course_code} - {self.course_title}"

class Instructor(models.Model):
    name = models.CharField(max_length=100, null=True)
    gender = models.CharField(max_length=1, choices=[('M', 'Male'),('F', 'Female'),('O', 'Other')], null=True)
    email = models.EmailField(unique=True, null=True)
    contact = models.CharField(max_length=15, null=True)
    address = models.TextField(null=True)

    def __str__(self):
        return self.name
    
class Checklist(models.Model):
    student = models.OneToOneField("auth.User",on_delete=models.CASCADE, related_name="checklist")
    program = models.ForeignKey(Program, on_delete=models.CASCADE, null=True,default=1)
    subjects = models.ManyToManyField(Subject, through="ChecklistItem")

class ChecklistItem(models.Model):
    checklist = models.ForeignKey(Checklist, on_delete=models.CASCADE, related_name="items")
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    grade = models.FloatField(null=True, blank=True)  # Null until graded
    status = models.CharField(
        max_length=20,
        choices=[
            ("Pending", "Pending"),
            ("Passed", "Passed"),
            ("Failed", "Failed"),
            ("Dropped", "Dropped"),
        ],
        default="Pending"
    )
    instructor = models.CharField(max_length=100, blank=True)

    def __str__(self):
        return f"{self.subject.course_code} - {self.status}"
