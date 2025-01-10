from django.shortcuts import render , redirect, get_object_or_404
from django.http import HttpResponse,JsonResponse
from .models import student, Subject, Instructor
from .cor import generate_cor
from django.template.loader import get_template
from xhtml2pdf import pisa
import datetime
from django.contrib.auth.models import User
from django.contrib import messages
from django.core.mail import send_mail
from django.utils.crypto import get_random_string
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required


allstudents = student.objects.all()
number_of_students_enrolled = student.objects.all().count()

def home(request):
    context = {
        'allstudents':allstudents,
        'number_of_students_enrolled':number_of_students_enrolled
    }

    return render(request, 'admin_dashboard/index.html', context)

def admin_profile(request):
    return render(request, "admin_dashboard/profile.html",{})
def admin_masterlist(request):
    return render(request, "admin_dashboard/masterlist.html",{'allstudents':allstudents})
def admin_schedule(request):
    return render(request, "admin_dashboard/schedule.html",{})
def admin_enrollment(request):
    return render(request, "admin_dashboard/student-enrollment.html",{})
def admin_checklist(request):
    return render(request, "admin_dashboard/checklist.html",{})

def admin_config(request):
    subjects = Subject.objects.all()
    instructors = Instructor.objects.all()
    return render(request, "admin_dashboard/config.html", {'subjects': subjects,'instructors': instructors})

@login_required
def save_subject(request):
    if request.method == 'POST':
        subject_id = request.POST.get('subject_id')
        course_code = request.POST['course_code']
        course_title = request.POST['course_title']
        year = request.POST['year']
        semester = request.POST['semester']
        subject_units_lec = request.POST['subject_units_lec']
        subject_units_lab = request.POST['subject_units_lab']
        prerequisites = request.POST.getlist('prerequisites')

        # prerequisite = None
        # if prerequisite_id:
        #     prerequisite = subject.objects.get(pk=prerequisite_id)
        
        if subject_id:
            subject = get_object_or_404(Subject, id=subject_id)
            subject.course_code = course_code
            subject.course_title = course_title
            subject.year = year
            subject.semester = semester
            subject.subject_units_lec = subject_units_lec
            subject.subject_units_lab = subject_units_lab
            # subject.prerequisite = prerequisite
            subject.save()
            subject.prerequisite.set(prerequisites)
            success = True
        else:
            subject = Subject.objects.create(
                course_code=course_code,
                course_title=course_title,
                year=year,
                semester=semester,
                subject_units_lec=subject_units_lec,
                subject_units_lab=subject_units_lab
                # prerequisite=prerequisite
            )
            subject.prerequisite.set(prerequisites)
            success = True
        
        if success:
            return JsonResponse({'success': True})
        else:
            return JsonResponse({'success': False, 'error': 'An error occurred while saving the subject.'})
 
def delete_subject(request, subject_id):
    if request.method == 'GET':
        subject = get_object_or_404(Subject, id=subject_id)
        subject.delete()
        return redirect('admin_config')
    else:
        return redirect('admin_config')

from django.shortcuts import redirect, get_object_or_404
from .models import Instructor

def save_instructor(request):
    if request.method == 'POST':
        instructor_id = request.POST.get('instructor_id')  # Hidden field to identify the instructor
        name = request.POST.get('instructor_name')
        gender = request.POST.get('gender')
        email = request.POST.get('email')
        contact = request.POST.get('contact')
        address = request.POST.get('address')

        if instructor_id:  # Edit existing instructor
            instructor = get_object_or_404(Instructor, id=instructor_id)
            instructor.name = name
            instructor.gender = gender
            instructor.email = email
            instructor.contact = contact
            instructor.address = address
            instructor.save()
        else:  # Add new instructor
            Instructor.objects.create(
                name=name,
                gender=gender,
                email=email,
                contact=contact,
                address=address
            )

        return JsonResponse({'success': True})

def delete_instructor(request, instructor_id):
    if request.method == 'GET':
        instructor = get_object_or_404(Instructor, id=instructor_id)
        instructor.delete()
        return redirect('admin_config')
    else:
        return redirect('admin_config')
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
        studenttype = request.POST.get('studentType')

        username = f"{last_name.lower()}{first_name.lower()}"
        password = get_random_string(8)

        try:
            user = User.objects.create_user(
                username = username,
                email = email,
                first_name = first_name,
                last_name = last_name,
                password = password,
            )
            user.is_staff = False
            user.is_superuser = False
            user.save()
        
            student_info = student.objects.create(
                user = user,
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
                new_or_old = studenttype,
                )
            student_info.save()

            send_mail(
                subject="Your Enrollment Account Details",
                message=f"Hello {first_name},\n\nYour account has been created.\nUsername: {username}\nPassword: {password}\n\nPlease log in and change your password immediately.",
                from_email="enrollmentdcsnoreply@gmail.com",
                recipient_list = [email],
                fail_silently=False,
            )

            messages.success(request, f"Student enrolled successfully and email sent! The generated password is {password}")
            return redirect('admin_dashboard')
        except Exception as e:
            messages.error(request, f"Error enrolling student: {e}")

        return HttpResponse("Data successfully updated!")
    else:
        return HttpResponse("Invalid request method.")

def search_students(request):

    if request.method == 'POST':

        search_year = request.POST.get('year_filter')
        search_course = request.POST.get('course_filter')
        search_student_id = request.POST.get('search_student_number')

        template = get_template('admin_dashboard/search_results.html')

        search_results = student.objects.filter(year=search_year).values() | student.objects.filter(course=search_course).values() | student.objects.filter(studentnumber=search_student_id).values()
        
        context = {
        'allstudents': allstudents,
        'search_results': search_results
        }

        return HttpResponse(template.render(context, request))
    else:
        return HttpResponse("Not Found")

def process_cor(request, student_number):

    template = get_template('admin_dashboard/process_cor.html')
    enrolled_student = student.objects.get(studentnumber=student_number)
    subject_code = Subject.objects.order_by('course_code')
    current_school_year = datetime.date.today().year
    previous_school_year = datetime.date.today().year - 1
    next_school_year = datetime.date.today().year + 1

    context = {
        'enrolled_student': enrolled_student,
        'subject_codes':subject_code,
        'current_SY':current_school_year,
        'previous_SY':previous_school_year,
        'next_SY':next_school_year,
    }

    return HttpResponse(template.render(context, request))


def edit_info(request, student_number):

    template = get_template('admin_dashboard/edit_student_info.html')
    enrolled_student = student.objects.get(studentnumber=student_number)
    context = {
        'enrolled_student':enrolled_student
    }
    return HttpResponse(template.render(context, request))


def update_info(request, student_number):

    template = get_template("admin_dashboard/masterlist.html")

    first_name = request.POST['first_name']
    last_name = request.POST['last_name']
    middle_name = request.POST['middle_name']
    Gender = request.POST['gender']
    contact_info = request.POST['contactNumber']
    email = request.POST['email']
    address = request.POST['Address']
    studentyear = request.POST['yearlevel']
    Sectionyear = request.POST['year_standing']
    Section = request.POST['section']
    Course = request.POST['course']
    Major = request.POST['major']
    Suffix = request.POST['suffix']
    Status = request.POST['status']
    studenttype = request.POST['studentType']

    student.objects.filter(studentnumber=student_number).update(
        firstname = first_name, 
        lastname = last_name,
        middlename = middle_name,
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
        new_or_old = studenttype
        
    )
    context = {}

    return HttpResponse(template.render(context, request))

def print_cor(request, student_number):
        
        if request.method == 'POST':
        
            enrolled_student = student.objects.filter(studentnumber = student_number)
            semester = request.POST.get('semester')
            yearstanding = request.POST.get('yearstanding')
            section = request.POST.get('section')
            yearlevel = request.POST.get('yearlevel')
            old_new = request.POST.get('old/new')
            status = request.POST.get('status')
            date_enrolled = datetime.date.today()

            subject1 = request.POST.get('subject1')
            subject2 = request.POST.get('subject2')
            subject3 = request.POST.get('subject3')
            subject4 = request.POST.get('subject4')
            subject5 = request.POST.get('subject5')
            subject6 = request.POST.get('subject6')
            subject7 = request.POST.get('subject7')
            subject8 = request.POST.get('subject8')
            subject9 = request.POST.get('subject9')
            subject10 = request.POST.get('subject10')

            context = {
                'enrolled_student': enrolled_student,
                'semester': semester,
                'yearstanding': yearstanding,
                'section': section,
                'yearlevel': yearlevel,
                'old_new': old_new,
                'status': status,
                'date_enrolled': date_enrolled,

                'subject1': Subject.objects.filter(course_code=subject1).values(),
                'subject2': Subject.objects.filter(course_code=subject2).values(),
                'subject3': Subject.objects.filter(course_code=subject3).values(),
                'subject4': Subject.objects.filter(course_code=subject4).values(),
                'subject5': Subject.objects.filter(course_code=subject5).values(),
                'subject6': Subject.objects.filter(course_code=subject6).values(),
                'subject7': Subject.objects.filter(course_code=subject7).values(),
                'subject8': Subject.objects.filter(course_code=subject8).values(),
                'subject9': Subject.objects.filter(course_code=subject9).values(),
                'subject10': Subject.objects.filter(course_code=subject10).values(),

                'allsubjects': ['subject1', 'subject2', 'subject3', 'subject4', 'subject5', 'subject6', 'subject7', 'subject8', 'subject9', 'subject10']

            }

            cor = generate_cor('admin_dashboard/cor_template.html', context)

            return HttpResponse(cor, content_type='application/pdf')

