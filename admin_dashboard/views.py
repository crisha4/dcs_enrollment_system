from django.shortcuts import render , redirect, get_object_or_404
from django.http import HttpResponse,JsonResponse
from .models import student, Subject, Instructor, Program, Checklist, ChecklistItem, school_fees
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
        'number_of_students_enrolled':student.objects.all().count()
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
    subject_code = Subject.objects.filter(program=enrolled_student.course).order_by('year', 'semester', 'course_code')
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

        enrolled_student = student.objects.get(studentnumber = student_number)
        semester = request.POST.get('semester')
        yearstanding = request.POST.get('yearstanding')
        Section = request.POST.get('section')
        old_new = request.POST.get('old_new')
        Status = request.POST.get('status')
        school_year = request.POST.get('schoolyear')
        other_fees = request.POST.get('other_fees')
        late_reg = request.POST.get('late_reg')
        ID_fee = request.POST.get('ID_fee')
        student_checklist, created = Checklist.objects.get_or_create(student__student__studentnumber=student_number)

        date_enrolled = datetime.today()
        tuition = 0
        lab_fee = 0
        nstp_fee = 0
        total_amount = 0
        total_units_lab = 0
        total_units_lec = 0
        total_units = 0

        match(yearstanding):
            case "1":
                yearlevel = '1st Year'
            case "2":
                yearlevel = '2nd Year'
            case "3":
                yearlevel = '3rd Year'
            case "4":
                yearlevel = '4th Year'
            case _:
                return HttpResponse("Please enter 1 to 4 in year standing")

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

        input_subjects = [subject1, subject2, subject3, subject4, subject5, subject6, subject7, subject8, subject9, subject10]

        for sub in input_subjects:

            units_lab = Subject.objects.filter(course_code=sub).values_list('subject_units_lab')
            units_lec = Subject.objects.filter(course_code=sub).values_list('subject_units_lec')

            for subject in units_lab:
                for lab_units in subject:
                    if lab_units == None:
                        lab_units = 0
                    int(lab_units)
                    total_units_lab += lab_units


            for subject in units_lec:
                for lec_units in subject:
                    if lec_units == None:
                        lec_units = 0

                    int(lec_units)
                    total_units_lec += lec_units
            
            total_units = total_units_lec + total_units_lab

        fees_list = ['lab_fees', 'reg_fee', 'insurance', 'sfdf', 'srf', 'misc', 'athletics', 'scuaa', 'library_fee', 'tuition_fee']


        if "NSTP 1" in input_subjects or "NSTP 2" in input_subjects:

            fee_values = school_fees.objects.filter(school_fee_name="nstp_fee").values_list('school_fee_value')

            for fees in fee_values:
                for values in fees:
                    float(values)
                    nstp_fee += values
                    total_amount += values
                    

        for fee_names in fees_list:

            fee_values = school_fees.objects.filter(school_fee_name=fee_names).values_list('school_fee_value')
            
            if fee_names == 'tuition_fee':
                for fees in fee_values:
                    for values in fees:
                        float(values)
                        tuition = total_units * values

            if fee_names == 'lab_fees':

                if total_units_lab == 0:
                    print("Total units lab", total_units_lab)
                    continue

                for fees in fee_values:
                    for values in fees:
                        float(values)
                        print("for lab fees","-",values)
                        total_amount += values
                        lab_fee += values
    

            for fees in fee_values:
                if fee_names == 'tuition_fee' or fee_names == 'lab_fees' or fee_names == 'nstp_fee':
                    continue
                for values in fees:
                    float(values)
                    print(fee_names,"-",values, "Total units lab",total_units_lab)
                    total_amount += values
                    


        total_amount += tuition

        if late_reg == "":
            late_reg = 0
        if other_fees == "":
            other_fees = 0

        total_amount = float(total_amount) + float(late_reg)
        total_amount = float(total_amount) + float(other_fees)
        total_amount = float(total_amount) + float(ID_fee)

        for sub in input_subjects:
            if sub:
                try: 
                    subject_instance = Subject.objects.get(program=enrolled_student.course, course_code=sub)
                    ChecklistItem.objects.get_or_create(
                        checklist = student_checklist,
                        subject = subject_instance,
                        defaults={
                            "status": "Pending",
                            "instructor": None,
                        },
                    )
                except Subject.DoesNotExist:
                    print(f'Subject with code {sub} does not exist.')

        context = {

            'enrolled_student': enrolled_student,
            'semester': semester,
            'yearstanding': yearstanding,
            'section': Section,
            'yearlevel': yearlevel,
            'old_new': old_new,
            'status': Status,
            'schoolyear': school_year,
            'date_enrolled': date_enrolled,
            'total_units': total_units,
            'total_units_lab': total_units_lab,
            'id_fee': ID_fee,
            'tuition_fee': tuition,
            'late_reg': late_reg,
            'lab_fee': lab_fee,
            'nstp_fee': nstp_fee,
            'other_fees': other_fees,
            'total_amount': total_amount,

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

            
            'reg_fee': school_fees.objects.filter(school_fee_name='reg_fee').values(),
            'insurance_fee': school_fees.objects.filter(school_fee_name='insurance').values(),
            'sfdf_fee': school_fees.objects.filter(school_fee_name='sfdf').values(),
            'srf_fee': school_fees.objects.filter(school_fee_name='srf').values(),
            'misc_fee': school_fees.objects.filter(school_fee_name='misc').values(),
            'athletics_fee': school_fees.objects.filter(school_fee_name='athletics').values(),
            'scuaa_fee': school_fees.objects.filter(school_fee_name='scuaa').values(),
            'library_fee': school_fees.objects.filter(school_fee_name='library_fee').values(),
            'other_fee': school_fees.objects.filter(school_fee_name='other_fees').values(),

            'user': request.user,
        }



        student.objects.filter(studentnumber=student_number).update(

            sectionyear = yearstanding,
            year = yearlevel,
            section = Section,
            new_or_old = old_new,
            status = Status,

        )

        cor = generate_cor('admin_dashboard/cor_template.html', context)

        return HttpResponse(cor, content_type='application/pdf')

