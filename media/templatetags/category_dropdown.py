from django import template
from media.models import Category

register = template.Library()

@register.inclusion_tag("media/categories_dropdown.html")
def category_dropdown():
    categories = Category.objects.all()
    return {'categories': categories}