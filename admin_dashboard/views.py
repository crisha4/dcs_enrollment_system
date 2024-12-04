from django.shortcuts import render
from django.http import HttpResponse
from .models import student
from .cor import generate_cor
from . import views
from django.template import loader
from django.template.loader import get_template
from xhtml2pdf import pisa
import datetime

allstudents = student.objects.all()
number_of_students_enrolled = student.objects.all().count()

def home(request):
    template = loader.get_template('admin_dashboard/index.html')
    context = {
        'allstudents':allstudents,
        'number_of_students_enrolled':number_of_students_enrolled
    }

    return HttpResponse(template.render(context, request))

def admin_profile(request):
    return render(request, "admin_dashboard/profile.html",{})
def admin_masterlist(request):
    return render(request, "admin_dashboard/masterlist.html",{})
def admin_schedule(request):
    return render(request, "admin_dashboard/schedule.html",{})
def admin_enrollment(request):
    return render(request, "admin_dashboard/student-enrollment.html",{})
def admin_checklist(request):
    return render(request, "admin_dashboard/checklist.html",{})



def enroll_student(request):

    if request.method == 'POST':
        allstudents = student.objects.all().count()
        intyear = datetime.date.today().year
        year = str(intyear)
        result = int(allstudents)

        student_number = "{:05d}".format(result)

        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        middle_name = request.POST.get('middle_name')
        Dateofbirth = request.POST.get('dob')
        Gender = request.POST.get('gender')
        contact_info = request.POST.get('contactNumber')
        email = request.POST.get('email')
        address = request.POST.get('Address')
        studentyear = request.POST.get('yearlevel')
        Sectionyear = request.POST.get('year_standing')
        Section = request.POST.get('section')
        Course = request.POST.get('course')
        Major = request.POST.get('major')
        Suffix = request.POST.get('suffix')
        Status = request.POST.get('status')

        
        student_info = student(
            studentnumber = year + student_number,
            firstname = first_name, 
            lastname = last_name,
            middlename = middle_name,
            dateofbirth = Dateofbirth,
            gender = Gender,
            suffix = Suffix,
            contact = contact_info,
            email = email,
            address = address,
            year = studentyear,
            sectionyear = Sectionyear,
            section = Section,
            course = Course,
            major = Major,
            status = Status,
            )
        student_info.save()

        return HttpResponse("Data successfully inserted!", process_cor)
    else:
        return HttpResponse("Invalid request method.")

def process_cor(request):
        cor = generate_cor('cor_template.html')
        return HttpResponse(cor, content_type='application/pdf')