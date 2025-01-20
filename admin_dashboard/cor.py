from io import BytesIO
from django.http import HttpResponse
from django.template.loader import get_template
from xhtml2pdf import pisa
import datetime


current_schoolyear = datetime.datetime.now().year
ending_schoolyear = current_schoolyear + 1
date_enrolled = datetime.date.today()

def generate_cor(cor_template, context={}):

    template = get_template(cor_template)
    html = template.render(context)
    data = BytesIO()
    #ISO-8859-1
    pdf = pisa.pisaDocument(BytesIO(html.encode("UTF-8")), data)
    if not pdf.err:
        return HttpResponse(data.getvalue(), content_type='application/pdf')
    return None