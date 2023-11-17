 
from django.urls import path, include

from bot import views

urlpatterns = [
    path("channel/<int:channel_id>", views.get_channel_info),
 ]