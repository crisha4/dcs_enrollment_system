# Generated by Django 5.1.3 on 2025-01-21 14:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('admin_dashboard', '0012_enrollment_dates'),
    ]

    operations = [
        migrations.AlterField(
            model_name='enrollment_dates',
            name='day',
            field=models.IntegerField(null=True),
        ),
        migrations.AlterField(
            model_name='enrollment_dates',
            name='month',
            field=models.IntegerField(null=True),
        ),
    ]
