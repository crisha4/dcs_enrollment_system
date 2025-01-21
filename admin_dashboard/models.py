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
    sectionyear = models.CharField(max_length=50, null=True)
    section = models.CharField(max_length=50, null=True)
    major = models.CharField(max_length=50, null=True)
    status = models.CharField(max_length=50, null=True)
    new_or_old = models.CharField(max_length=50, null=True)


    class Meta:
        db_table = 'students'

class subjects(models.Model):
    
    course_code = models.CharField(max_length=50, null=True)
    course_description = models.CharField(max_length=50, null=True)
    subject_units_lec = models.IntegerField(null=True)
    subject_units_lab = models.IntegerField(null=True)

    class Meta:
        db_table = 'subject'

class school_fees(models.Model):

    school_fee_name = models.CharField(max_length=50, null=True)
    school_fee_value = models.DecimalField(max_digits=6, decimal_places=2, null=True)

    class Meta:
        db_table = 'school_fee'

class enrollment_dates(models.Model):

    enrollment_period = models.CharField(max_length=50, null=True)
    year = models.IntegerField(null=True)
    month = models.IntegerField(null=True)
    day = models.IntegerField(null=True)

    class Meta:
        db_table = 'enrollment_date'


    
