from django import forms
from django.forms import widgets

from .models import Category, Language, Comment
from .views import *
import uuid
from taggit.forms import TagField

class HandleForm(forms.Form):
    FUNCTION_CHOICES = (
        ('1', 'Channels'),
        ('group', 'Groups'),
        ('bot', 'Bots'),
    )
    
    function = forms.ChoiceField(
        choices=FUNCTION_CHOICES,
        label='Function',
        widget=forms.Select(attrs={'class': 'form-control'})
    )
    handle = forms.CharField(label='Handle', required=True, widget=forms.TextInput(attrs={'class': 'form-control'}))


# Media Form
class MediaForm(forms.Form):
    description = forms.CharField(label="Description", widget=forms.Textarea)
    body = forms.CharField(label="Body", widget=forms.Textarea, required=False)
    category = forms.ModelChoiceField(queryset=Category.objects.all(), label="Category", empty_label="Select a category")
    language = forms.ModelChoiceField(queryset=Language.objects.all(), label="Language", empty_label="Select a language")
    nsfw = forms.BooleanField(label="NSFW", required=False)
    tags = TagField(label="Tags", required=False)

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['text']

class PageUrlForm(forms.Form):
    url = forms.CharField(label="Page URL", max_length=200)
