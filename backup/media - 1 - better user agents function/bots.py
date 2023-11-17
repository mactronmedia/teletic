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
from django.shortcuts import render, get_object_or_404
from django.views import View
from django.views.generic import FormView
from django.urls import reverse_lazy

from .forms import MediaForm
from .models import Media, Category, Language, Type

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
         
        return self.scrape_bot_data(request, handle)

    def scrape_bot_data(self, request, handle):
        try:
            Media.objects.get(handle=handle)
            error_message = "Media already exists in the database."
            return render(request, self.template_name, {'error_message': error_message})
        except Media.DoesNotExist:
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
            file_path = settings.LOGO_PHOTO
            thumbnail_file_path = settings.THUMBNAIL_PHOTO
            
            if ".jpg" in bot_photo:
                current_month = datetime.now().month
                directory = f"{current_month:02d}"  # Pad the month with leading zeros
                folder_path = os.path.join("storage/channels", directory)
                os.makedirs(folder_path, exist_ok=True)

                parsed_url = urlparse(bot_photo)
                file_extension = os.path.splitext(parsed_url.path)[1][1:]
                new_file_name = f"{handle}_logo.{file_extension}"
                file_path = os.path.join(folder_path, new_file_name)

                if not os.path.exists(file_path):
                    image_data = requests.get(bot_photo).content
                    with open(file_path, "wb") as image_file:
                        image_file.write(image_data)

                thumbnail_file_name = f"{handle}_thumbnail.{file_extension}"
                thumbnail_file_path = os.path.join(folder_path, thumbnail_file_name)

                if not os.path.exists(thumbnail_file_path):
                    with Image.open(file_path) as image:
                        image.thumbnail((150, 150))
                        image.save(thumbnail_file_path)
                
            data = {
                'handle': handle,
                'name': bot_name,
                'description': bot_description,
                'avatar': bot_photo,
                'logo_path': file_path,
                'thumb_path': thumbnail_file_path
            }

            request.session['data'] = data

            media_form = MediaForm()
            return render(request, self.template_name, {'data': data, 'media_form': media_form})
        
class HandleBotFormView(FormView):
    template_name = 'scrape.html'
    template_added = "success.html"
    form_class = MediaForm
    success_url = reverse_lazy('scrape_data')

    def form_valid(self, form):
        data = self.request.session.get('data', None)

        if not data:
            messages.error(self.request, 'No group data found in session.')
        else:
            category_id = form.cleaned_data['category'].id if form.cleaned_data['category'] else None
            language_id = form.cleaned_data['language'].id if form.cleaned_data['language'] else None

            data.update({
                'body': form.cleaned_data['body'],
                'category_id': category_id,
                'category_name': form.cleaned_data['category'].name if form.cleaned_data['category'] else None,
                'language_id': language_id,
                'nsfw': form.cleaned_data['nsfw'],  # Add the nsfw value to the data dictionary
            })
            StoreBotData.save_data(data)

        return render(self.request, self.template_added, {'data': data, 'media_form': form})

class StoreBotData:
    @staticmethod
    def save_data(data):
        category = get_object_or_404(Category, id=data.get('category_id'))
        language = get_object_or_404(Language, id=data.get('language_id'))
        nsfw = data.get('nsfw', False)
        type_id = 3  # hardcoded!
        type_obj = get_object_or_404(Type, id=type_id)

        group = Media.objects.create(
            handle=data['handle'],
            name=data['name'],
            description=data['description'],
            logo_path=data['logo_path'],
            thumb_path=data['thumb_path'],
            body=data['body'],
            category=category,
            language=language,
            type=type_obj,
            nsfw=nsfw
        )

 