import os
import re
import requests
from datetime import datetime
from urllib.parse import urlparse

from PIL import Image
from bs4 import BeautifulSoup
from fake_useragent import UserAgent

from django.conf import settings
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.http import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from django.views import View
from django.views.generic import FormView

from .forms import MediaForm
from .models import Media, Category, Language, Type, GroupCounter
from taggit.models import Tag


class ScrapeBotDataView(View):
    template_name = "scrape.html"
    session = requests.Session()
    user_agent = UserAgent()

    def get(self, request):
        media_form = MediaForm()
        return render(request, self.template_name, {'media_form': media_form})

    def post(self, request, handle):
        if 'handle_form_submit' in request.POST:
            form_view = HandleBotFormView.as_view()
            return form_view(request)
        handle = handle.lower()
         
        return self.bot_exists(request, handle)

    def bot_exists(self, request, handle):
        try:
            Media.objects.get(handle=handle)
            error_message = "Media already exists in the database."
            return render(request, self.template_name, {"error_message": error_message})
        except Media.DoesNotExist:
            bot_data = self.scrape_bot_data(handle)

            if "error_message" in bot_data:  # Check if an error message was returned
                return render(request, self.template_name, {"error_message": bot_data["error_message"]})

            request.session["data"] = bot_data

            media_form = MediaForm()

            return render(
                request,
                self.template_name,
                {
                    "data": bot_data,
                    "media_form": media_form,
                },
            )

    def scrape_bot_data(self, handle):
        url = f"https://t.me/{handle}"
        headers ={"User-Agent":self.user_agent.random}

        print("User-Agent Header:", headers["User-Agent"])  # Print the user agent

        page = self.session.get(url, headers=headers)
        soup = BeautifulSoup(page.content, 'lxml')

        # Get Bot Name
        bot_name = soup.find('span', attrs={'dir': 'auto'})
        bot_name = bot_name.text.strip() if bot_name else ""

        bot_description = soup.find('div', attrs={'class': 'tgme_page_description'})
        bot_description = ' '.join(bot_description.stripped_strings) if bot_description else ""



        # Get Bot Photo
        bot_photo = soup.find("meta", attrs={"property": "og:image"})["content"]
        file_path, thumbnail_file_path = self.download_photo(handle, bot_photo)
  
        data = {
            'handle': handle,
            'name': bot_name,
            'description': bot_description,
            'avatar': bot_photo,
            'logo_path': file_path,
            'thumb_path': thumbnail_file_path
        }

        return data

    def download_photo(self, handle, bot_photo):
        file_path = settings.LOGO_PHOTO
        thumbnail_file_path = settings.THUMBNAIL_PHOTO

        if ".jpg" in bot_photo:
            current_month = datetime.now().month
            directory = f"{current_month:02d}"
            folder_path = os.path.join("storage/bots", directory)
            os.makedirs(folder_path, exist_ok=True)

            parsed_url = urlparse(bot_photo)
            file_extension = os.path.splitext(parsed_url.path)[1][1:]
            new_file_name = f"{handle}_logo.{file_extension}"
            file_path = os.path.join(folder_path, new_file_name)

            if not os.path.exists(file_path):
                image_data = requests.get(bot_photo).content
                with open(file_path, "wb") as image_file:
                    image_file.write(image_data)

            thumbnail_file_name = f"{handle}_thumb.{file_extension}"
            thumbnail_file_path = os.path.join(folder_path, thumbnail_file_name)

            if not os.path.exists(thumbnail_file_path):
                with Image.open(file_path) as image:
                    image.thumbnail((150, 150))
                    image.save(thumbnail_file_path)

        return file_path, thumbnail_file_path
    

class HandleBotFormView(FormView):
    form_class = MediaForm
    success_url = "/success/"  # URL to redirect after successful form submission

    def form_valid(self, form):
        data = self.request.session.get("data", {})
        if not data:
            messages.error(self.request, "No bots data found in session.")
            return redirect(reverse("media"))  # Redirect back to the scrape page

        category = form.cleaned_data.get('category')
        language = form.cleaned_data.get('language')
        category_id = category.id if category else None
        language_id = language.id if language else None

        data.update({
            "body": form.cleaned_data.get("body"),
            "description": form.cleaned_data.get("description"),
            "category_id": category_id,
            "category_name": category.name if category else None,
            "language_id": language_id,
            "nsfw": form.cleaned_data.get("nsfw", False),
            "tags": form.cleaned_data.get("tags"),

          })
        
        return StoreBotData.save_data(self.request, data)

class StoreBotData:
    @staticmethod
    def save_data(request, data):
        category_id = data.get('category_id')
        language_id = data.get('language_id')
        nsfw = data.get('nsfw', False)
        type_id = 3 # hardcoded!
        type_obj = Type.objects.get(id=type_id)

        handle = data['handle']

        bot = Media.objects.create(
            handle=data['handle'],
            name=data['name'],
            description=data['description'],
            logo_path=data['logo_path'],
            thumb_path=data['thumb_path'],
            body=data['body'],
            category_id=category_id,
            language_id=language_id,
            type=type_obj,
            nsfw=nsfw,
        )

        bot.tags.add(*data["tags"])

        return redirect(reverse("success"))  # Redirect to a success page after saving the data        