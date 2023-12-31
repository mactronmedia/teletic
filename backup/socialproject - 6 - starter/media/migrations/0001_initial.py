# Generated by Django 4.1.2 on 2023-08-02 12:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('description', models.TextField()),
                ('slug', models.SlugField(max_length=100, unique=True)),
            ],
            options={
                'verbose_name_plural': 'Categories',
            },
        ),
        migrations.CreateModel(
            name='Language',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('code', models.CharField(max_length=10)),
                ('slug', models.SlugField(blank=True, max_length=255, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Type',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=200)),
                ('description', models.TextField()),
                ('slug', models.SlugField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Media',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('handle', models.CharField(max_length=255, unique=True)),
                ('name', models.CharField(max_length=200)),
                ('description', models.TextField()),
                ('body', models.TextField(null=True)),
                ('nsfw', models.BooleanField(default=False)),
                ('accept_payments', models.BooleanField(default=False)),
                ('status', models.IntegerField(choices=[(0, 'Waiting for Approval'), (1, 'Approved'), (2, 'Featured')], default=0)),
                ('logo_path', models.CharField(max_length=100)),
                ('thumb_path', models.CharField(max_length=100)),
                ('published', models.DateField(auto_now_add=True)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='media.category')),
                ('language', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='media.language')),
                ('type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='media.type')),
            ],
        ),
        migrations.CreateModel(
            name='GroupCounter',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('members', models.IntegerField(null=True)),
                ('group', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='media.media')),
            ],
        ),
        migrations.CreateModel(
            name='ChannelCounter',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('subscribers', models.IntegerField(null=True)),
                ('photos', models.CharField(max_length=20, null=True)),
                ('videos', models.CharField(max_length=20, null=True)),
                ('files', models.CharField(max_length=20, null=True)),
                ('links', models.CharField(max_length=20, null=True)),
                ('updated', models.DateField(auto_now_add=True)),
                ('channel', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='media.media')),
            ],
        ),
    ]
