# Generated by Django 5.1.3 on 2024-12-17 03:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('admin_dashboard', '0003_alter_student_studentnumber'),
    ]

    operations = [
        migrations.CreateModel(
            name='personal_info',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('studentnumber', models.CharField(max_length=100, null=True)),
                ('firstname', models.CharField(max_length=100, null=True)),
                ('middlename', models.CharField(max_length=100, null=True)),
                ('lastname', models.CharField(max_length=100, null=True)),
                ('suffix', models.CharField(max_length=100, null=True)),
                ('dateofbirth', models.DateField(null=True)),
                ('gender', models.CharField(max_length=10, null=True)),
                ('email', models.EmailField(max_length=254, null=True)),
                ('contact', models.CharField(max_length=255, null=True)),
                ('address', models.CharField(max_length=250, null=True)),
            ],
            options={
                'db_table': 'personal_info',
            },
        ),
        migrations.DeleteModel(
            name='student',
        ),
    ]