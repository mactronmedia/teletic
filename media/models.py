from django.db import models
from django.core.cache import cache

from django.urls import reverse
from django.utils.text import slugify
from django.core.exceptions import ValidationError
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin, Permission
from django.contrib.auth.models import Group as AuthGroup  # Rename to avoid conflict
from django.views import View
from taggit.managers import TaggableManager
from django.db.models import Sum


class Category(models.Model):
    class Meta(object):
        verbose_name_plural = 'Categories'

    name = models.CharField(max_length=50)
    title = models.CharField(max_length=200)
    description = models.TextField()
    slug = models.SlugField(max_length=100, unique=True)

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Language(models.Model):
    name = models.CharField(max_length=50)
    title = models.CharField(max_length=200)
    description = models.TextField()
    code = models.CharField(max_length=10)
    slug = models.SlugField(unique=True, max_length=255, blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)  # Generate the slug from the name if it's not set
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Type(models.Model):
    name = models.CharField(max_length=50)
    title = models.CharField(max_length=200)
    description = models.TextField()
    slug = models.SlugField(max_length=100)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)  # Generate the slug from the name if it's not set
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Media(models.Model):   
    handle = models.CharField(max_length=255, unique=True)
    name = models.CharField(max_length=200)
    description = models.TextField()
    body = models.TextField(null=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, db_index=True)
    language = models.ForeignKey(Language, on_delete=models.CASCADE, db_index=True)
    type = models.ForeignKey(Type, on_delete=models.CASCADE, db_index=True)
    nsfw = models.BooleanField(default=False)
    accept_payments = models.BooleanField(default=False)
    status = models.IntegerField(choices=[(0, 'Waiting for Approval'), (1, 'Approved'), (2, 'Featured')], default=0)
    official = models.IntegerField(choices=[(0, 'Non Official'), (1, 'Official')], default=0)
    logo_path = models.CharField(max_length=100)
    thumb_path = models.CharField(max_length=100)
    created_at = models.DateField(auto_now=False, auto_now_add=False, null=True)
    published_at = models.DateTimeField(auto_now_add=True)
    tags = TaggableManager()

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Comment(models.Model):
    media = models.ForeignKey(Media, on_delete=models.CASCADE)
    #user = models.ForeignKey(User, on_delete=models.CASCADE)  # Assuming you have a User model
    text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    active = models.BooleanField(default=True)

    def __str__(self):
        return f"Comment by {self.user} on {self.media.name}"

class ChannelCounter(models.Model):
    channel = models.ForeignKey(Media, on_delete=models.CASCADE)
    subscribers = models.IntegerField(null=True)
    photos = models.CharField(max_length=20, null=True)
    videos = models.CharField(max_length=20, null=True)
    files = models.CharField(max_length=20, null=True)
    links = models.CharField(max_length=20, null=True)
    updated = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"{self.count} subscribers"

class GroupCounter(models.Model):
    group = models.ForeignKey(Media, on_delete=models.CASCADE)
    members = models.IntegerField(null=True)

    def __str__(self):
        return f"{self.count} members"
