from django.contrib import admin
from .models import Media, Category, Type, Language

admin.site.register(Media)
admin.site.register(Category)
admin.site.register(Language)
admin.site.register(Type)