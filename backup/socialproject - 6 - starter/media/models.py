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

    name = models.CharField(max_length=200)
    description = models.TextField()
    slug = models.SlugField(max_length=100, unique=True)

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Language(models.Model):
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=10)
    slug = models.SlugField(unique=True, max_length=255, blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)  # Generate the slug from the name if it's not set
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Type(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    slug = models.SlugField(max_length=100)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)  # Generate the slug from the name if it's not set
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Media(models.Model):
    # Fields for the Media model
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
    logo_path = models.CharField(max_length=100)
    thumb_path = models.CharField(max_length=100)
    published = models.DateField(auto_now_add=True)
    tags = TaggableManager()

 
    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name
    # Method to retrieve channels, groups, and bots based on type
    def get_channels_groups_bots(self):
        channels = Media.objects.select_related('category').filter(type__title='Channels')
        groups = Media.objects.select_related('category').filter(type__title='Groups')
        bots = Media.objects.select_related('category').filter(type__title='Bots')
        return channels, groups, bots

    # Method to retrieve channel-subscriber mapping
    def get_channel_subscriber_mapping(self, channels):
        channel_subscriber_mapping = {
            counter.channel_id: counter.total_subscribers for counter 
            in ChannelCounter.objects.filter(channel__in=channels).annotate(total_subscribers=Sum('subscribers'))
        }
        return channel_subscriber_mapping

    # Method to retrieve group-member mapping
    def get_group_member_mapping(self, groups):
        group_member_mapping = {
            counter.group_id: counter.total_members for counter 
            in GroupCounter.objects.filter(group__in=groups).annotate(total_members=Sum('members'))
        }
        return group_member_mapping

    # Method to create a context containing media information
    def get_media_context(self, channels, groups, bots, channel_subscriber_mapping, group_member_mapping):
        context = {
            'channels': [{'media': channel, 'subscribers': channel_subscriber_mapping.get(channel.id, 0)} for channel in channels],
            'groups': [{'media': group, 'members': group_member_mapping.get(group.id, 0)} for group in groups],
            'bots': [{'media': bot} for bot in bots],
            'total_channels': len(channels),
            'total_groups': len(groups),
            'total_bots': len(bots),
        }
        return context




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
