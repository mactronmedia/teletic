# Generated by Django 4.1.2 on 2023-08-11 01:44

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('media', '0003_remove_media_handle_media_slug'),
    ]

    operations = [
        migrations.RenameField(
            model_name='media',
            old_name='slug',
            new_name='handle',
        ),
    ]
