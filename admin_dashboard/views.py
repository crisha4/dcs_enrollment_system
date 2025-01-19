from django.shortcuts import render , redirect, get_object_or_404
from django.http import HttpResponse,JsonResponse
from .models import student, Subject, Instructor, Program, Checklist, school_fees
from .cor import generate_cor
from django.template.loader import get_template
from xhtml2pdf import pisa
from datetime import datetime
from django.contrib.auth.models import User
from django.contrib import messages
from django.core.mail import send_mail
from django.utils.crypto import get_random_string
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from decimal import Decimal
from django.db.utils import IntegrityError


allstudents = student.objects.all()
number_of_students_enrolled = student.objects.all().count()

def home(request):
    context = {
        'allstudents':student.objects.all(),
        'number_of_students_enrolled':number_of_students_enrolled
    }

    return render(request, 'admin_dashboard/index.html', context)

def admin_profile(request):
    return render(request, "admin_dashboard/profile.html",{})
def admin_masterlist(request):
    return render(request, "admin_dashboard/masterlist.html",{'allstudents':student.objects.all()})
def admin_schedule(request):
    return render(request, "admin_dashboard/schedule.html",{})

#------------FOR CREATING NEW STUDENT ACCOUNT, BOTH OLD AND NEW---------------------------------
def generateUniqueUsername(first_name, last_name):
    base_username = f"{last_name.strip().lower()}{first_name.strip().lower()}".replace(" ", "")

    username = base_username
    while User.objects.filter(username=username).exists():
        random_number = get_random_string(length=3,allowed_chars='0123456789')
        username = f"{base_username}{random_number}"

    return username
def admin_enrollment(request):
    return render(request, "admin_dashboard/new_or_old_enrollee.html",{})
def enroll_student(request, enrollee_type):
    if request.method == 'POST':
        student_number = None
        student_type = None

        if enrollee_type == 'new':
            current_year = datetime.now().year
            student_this_year = student.objects.filter(studentnumber__startswith=str(current_year)).count()
            student_number = f"{current_year}{student_this_year + 1:05d}"
            student_type = 'New'
        elif enrollee_type =='old':
            student_number = request.POST.get('studentnumber', '').strip()
            if not student_number:
                messages.error(request, "Student number is required for old students.")
                return render(request, "admin_dashboard/enroll_student.html", {'form_data':  request.POST, 'enrollee_type':enrollee_type, 'programs':Program.objects.all()})
            student_type = 'Old'
        else:
            messages.error(request, "Invalid enrollee type.")
            return render(request, "admin_dashboard/enroll_student.html",{'enrollee_type': enrollee_type, 'programs':Program.objects.all()})
        
        first_name = request.POST.get('first_name', '').strip()
        last_name = request.POST.get('last_name', '').strip()
        middle_name = request.POST.get('middle_name', '').strip()
        dob = request.POST.get('dob', '').strip()
        gender = request.POST.get('gender', '').strip()
        contact_info = request.POST.get('contactNumber', '').strip()
        email = request.POST.get('email', '').strip()
        address = request.POST.get('Address', '').strip()
        section_year = request.POST.get('year_standing', '').strip()

        year_map = {"1": "1st Year", "2": "2nd Year", "3": "3rd Year", "4": "4th Year"}
        student_year = year_map.get(section_year)
        if not student_year:
            messages.error(request, "Invalid year standing. Please enter a value between 1 and 4.")
            return render(request, "admin_dashboard/enroll_student.html", {'form_data': request.POST, 'enrollee_type':enrollee_type,'programs':Program.objects.all()})

        section = request.POST.get('section', '').strip()
        program_id = request.POST.get('program')
        suffix = request.POST.get('suffix', '').strip()
        status = request.POST.get('status', '').strip()

        course = get_object_or_404(Program, id=program_id)
        
        username = generateUniqueUsername(first_name, last_name)
        password =get_random_string(8)
        try:
            user = User.objects.create_user(
                username=username,
                email=email,
                first_name=first_name,
                last_name=last_name,
                password=password,
            )
            user.is_staff = False
            user.is_superuser = False
            user.save()

            student_info = student.objects.create(
                user=user,
                studentnumber=student_number,
                firstname=first_name,
                lastname=last_name,
                middlename=middle_name,
                dateofbirth=dob,
                gender=gender,
                suffix=suffix,
                contact=contact_info,
                email=email,
                address=address,
                year=student_year,
                sectionyear=section_year,
                section=section,
                course=course,
                status=status,
                new_or_old=student_type,
            )
            student_info.save()

            Checklist.objects.create(
                student=user,
                program=course,
            )

            send_mail(
                subject="Your Enrollment Account Details",
                message=f"Hello {first_name},\n\nYour account has been created.\nUsername: {username}\nPassword: {password}\n\nPlease log in and change your password immediately.",
                from_email="enrollmentdcsnoreply@gmail.com",
                recipient_list=[email],
                fail_silently=False,
            )

            messages.success(request, f"Student {student_number} enrolled successfully! Account details sent to {email}.\n\nUsername: {username}\nPassword:{password}")
            return render(request, "admin_dashboard/enroll_student.html", {
                'username': username,
                'password': password,
                'student_number': student_number,
                'enrollee_type': enrollee_type,
                'show_modal': True,
            })
        except IntegrityError:
            messages.error(request, "An error occured: Could not create a unique username. Please try again.")
        except Exception as e:
            messages.error(request, f"An error occurred while enrolling the student: {e}")
            return render(request, "admin_dashboard/enroll_student.html", {'form_data': request.POST, 'enrollee_type': enrollee_type,'programs':Program.objects.all()})
    return render(request, "admin_dashboard/enroll_student.html", {'enrollee_type': enrollee_type,'programs':Program.objects.all()})


def admin_checklist(request):
    return render(request, "admin_dashboard/checklist.html",{})
def grades_input(request):
    current_year = datetime.now().year
    academic_years = [f"{current_year}-{current_year + 1}",f"{current_year + 1}-{current_year + 2}",f"{current_year - 1}-{current_year}",]
    allstudents = student.objects.all()
    subject = Subject.objects.all()
    instructors = Instructor.objects.all()
    context = {
        "academic_years": academic_years,
        'student':allstudents,
        'subject':subject,
        'instructors':instructors
    }
    return render(request, "admin_dashboard/grades_input.html",context)

def fetch_student_checklist(request):
    student_number = request.GET.get('student_number')
    student_data = get_object_or_404(student, studentnumber=student_number)
    response_data ={
        "firstname": student_data.firstname,
        "middlename": student_data.middlename,
        "lastname": student_data.lastname,
        "suffix": student_data.suffix,
        "year": student_data.year,
        "course": student_data.course,
        "current_date": datetime.now().strftime("%B %d, %Y"),
    }
    return JsonResponse(response_data)

def fetch_subjects(request):
    program_id = request.GET.get('program_id')
    if not program_id:
        return JsonResponse({'error': 'Program ID missing'}, status=400)
    
    subjects = Subject.objects.filter(program_id=program_id).values(
        'id', 'course_code', 'course_title', 'subject_units_lec', 'subject_units_lab'
    )
    return JsonResponse(list(subjects), safe=False)

#-------------COONFIGURATION PAGE--SUBJECT---INSTRUCTOR------------------
def admin_config(request):
    subject_list = Subject.objects.all().prefetch_related('prerequisite')
    paginator = Paginator(subject_list, 10)  # Show 10 subjects per page

    page_number = request.GET.get('page')
    subjects = paginator.get_page(page_number)
    allsubjects = Subject.objects.all()
    instructors = Instructor.objects.all()
    programs = Program.objects.all()
    context = {'subjects': subjects, 'instructors': instructors, 'allsubjects': allsubjects, 'programs':programs}
    
    # return render(request, "admin_dashboard/config.html", {'subjects': subjects,'instructors': instructors})
    return render(request, "admin_dashboard/config.html", context)
@login_required
def save_subject(request):
    if request.method == 'POST':
        subject_id = request.POST.get('subject_id')
        course_code = request.POST['course_code']
        course_title = request.POST['course_title']
        program_id = request.POST.get('program')
        year = request.POST['year']
        semester = request.POST['semester']
        subject_units_lec = request.POST['subject_units_lec']
        subject_units_lab = request.POST['subject_units_lab']
        prerequisites = request.POST.getlist('prerequisites')

        program = get_object_or_404(Program, id=program_id)
    
        if subject_id:
            subject = get_object_or_404(Subject, id=subject_id)
            subject.course_code = course_code
            subject.course_title = course_title
            subject.program = program
            subject.year = year
            subject.semester = semester
            subject.subject_units_lec = subject_units_lec
            subject.subject_units_lab = subject_units_lab
            subject.save()
            subject.prerequisite.set(prerequisites)
            success = True
        else:
            subject = Subject.objects.create(
                course_code=course_code,
                course_title=course_title,
                program=program,
                year=year,
                semester=semester,
                subject_units_lec=subject_units_lec,
                subject_units_lab=subject_units_lab
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
    current_school_year = datetime.now().year
    previous_school_year = datetime.now().year - 1
    next_school_year = datetime.now().year + 1

    context = {
        'enrolled_student': enrolled_student,
        'subject_codes':subject_code,
        'current_SY':current_school_year,
        'previous_SY':previous_school_year,
        'next_SY':next_school_year,

        'lab_fee': school_fees.objects.filter(school_fee_name='lab_fees').values(),
        'reg_fee': school_fees.objects.filter(school_fee_name='reg_fee').values(),
        'insurance_fee': school_fees.objects.filter(school_fee_name='insurance').values(),
        'id_fee': school_fees.objects.filter(school_fee_name='id').values(),
        'sfdf_fee': school_fees.objects.filter(school_fee_name='sfdf').values(),
        'srf_fee': school_fees.objects.filter(school_fee_name='srf').values(),
        'misc_fee': school_fees.objects.filter(school_fee_name='misc').values(),
        'athletics_fee': school_fees.objects.filter(school_fee_name='athletics').values(),
        'scuaa_fee': school_fees.objects.filter(school_fee_name='scuaa').values(),
        'library_fee': school_fees.objects.filter(school_fee_name='library_free').values(),
        'other_fee': school_fees.objects.filter(school_fee_name='other_fees').values(),
    }

    return HttpResponse(template.render(context, request))


def edit_info(request, student_number):

    template = get_template('admin_dashboard/edit_student_info.html')
    enrolled_student = student.objects.get(studentnumber=student_number)
    context = {
        'enrolled_student':enrolled_student,
        'programs': Program.objects.all(),
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
    Sectionyear = request.POST['year_standing']

    match(Sectionyear):
            case "1":
                studentyear = '1st Year'
            case "2":
                studentyear = '2nd Year'
            case "3":
                studentyear = '3rd Year'
            case "4":
                studentyear = '4th Year'
            case _:
                return HttpResponse("Please enter 1 to 4 in year standing")
      
    
    Section = request.POST['section']
    program_id = request.POST['course']
    Suffix = request.POST['suffix']
    Status = request.POST['status']
    studenttype = request.POST['studentType']

    Course = get_object_or_404(Program, id=program_id)

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
        status = Status,
        new_or_old = studenttype
        
    )
    context = {'allstudents':student.objects.all()}

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
            date_enrolled = datetime.today()

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

