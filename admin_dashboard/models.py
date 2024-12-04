from django.db import models

class student(models.Model):

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
    sectionyear = models.IntegerField(null=True)
    section = models.IntegerField(null=True)
    major = models.CharField(max_length=50, null=True)
    status = models.CharField(max_length=50, null=True)


    class Meta:
        db_table = 'students'

class subjects(models.Model):
    
    course_code = models.CharField(max_length=50, null=True)
    course_description = models.CharField(max_length=50, null=True)
    subject_units_lec = models.IntegerField(null=True)
    subject_units_lab = models.IntegerField(null=True)

    class Meta:
        db_table = 'subject'

    
