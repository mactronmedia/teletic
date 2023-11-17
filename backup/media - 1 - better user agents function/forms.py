from django import forms
from django.forms import widgets

from .models import Category, Language
from .views import *
import uuid
from taggit.forms import TagField


class HandleForm(forms.Form):
    handle = forms.CharField(label='Handle', required=True)

# Media Form
class MediaForm(forms.Form):
    description = forms.CharField(label="Description", widget=forms.Textarea)
    body = forms.CharField(label="Body", widget=forms.Textarea, required=False)
    category = forms.ModelChoiceField(queryset=Category.objects.all(), label="Category", empty_label="Select a category")
    language = forms.ModelChoiceField(queryset=Language.objects.all(), label="Language", empty_label="Select a language")
    nsfw = forms.BooleanField(label="NSFW", required=False)
    tags = TagField(label="Tags", required=False)