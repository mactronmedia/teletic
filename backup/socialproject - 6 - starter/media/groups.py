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
from django.shortcuts import render, get_object_or_404
from django.urls import reverse
from django.views import View
from django.views.generic import FormView

from .forms import MediaForm
from .models import Media, Category, Language, Type, GroupCounter
from taggit.models import Tag


class ScrapeGroupDataView(View):
    template_name = "scrape.html"
    session = requests.Session()
    user_agent = UserAgent()

    def get(self, request):
        media_form = MediaForm()
        return render(request, self.template_name, {'media_form': media_form})

    def post(self, request, handle):
        if 'handle_form_submit' in request.POST:
            form_view = HandleGroupFormView.as_view()
            return form_view(request)
        handle = handle.lower()
        return self.scrape_group_data(request, handle)

    def scrape_group_data(self, request, handle):
        try:
            Media.objects.get(handle=handle)
            error_message = "Media already exists in the database."
            return render(request, self.template_name, {'error_message': error_message})
        except Media.DoesNotExist:
            url = f"https://t.me/{handle}"
            headers = {"User-Agent": self.user_agent.random}

            print("User-Agent Header:", headers["User-Agent"])  # Print the user agent

            page = self.session.get(url, headers=headers)
            soup = BeautifulSoup(page.content, 'lxml')

            group_name = soup.find('span', attrs={'dir': 'auto'})
            group_name = group_name.text.strip() if group_name else ""
            group_name = re.sub(r'[^\w\s\d]|_', '', group_name)  # remove emojis

            group_description = soup.find('div', attrs={'class': 'tgme_page_description'})
            group_description = ' '.join(group_description.stripped_strings) if group_description else ""

            group_members = soup.find('div', attrs={'class': 'tgme_page_extra'})
            if group_members is None or 'members' not in group_members.text:
                error_message = "Members not found. Wrong media!"
                return render(request, self.template_name, {'error_message': error_message})

            group_members = group_members.text.strip()
            group_members = group_members.split(" members")[0]
            group_members = re.sub('[^0-9]', '', group_members)
            group_members = "{:,}".format(int(group_members)) # add comma to the numbers ex: 1,000

            group_photo = soup.find('meta', attrs={'property': 'og:image'})["content"]
            file_path = settings.LOGO_PHOTO
            thumbnail_file_path = settings.THUMBNAIL_PHOTO

            if ".jpg" not in group_photo:
                current_month = datetime.now().month
                directory = f"{current_month:02d}"  # Pad the month with leading zeros
                folder_path = os.path.join("media/groups", directory)
                os.makedirs(folder_path, exist_ok=True)

                parsed_url = urlparse(group_photo)
                file_extension = os.path.splitext(group_photo)[1][1:]
                new_file_name = f"{handle}_logo.{file_extension}"
                file_path = os.path.join(folder_path, new_file_name)

                if not os.path.exists(file_path):
                    image_data = requests.get(group_photo).content
                    with open(file_path, "wb") as image_file:
                        image_file.write(image_data)

                thumbnail_file_name = f"{handle}_thumb.{file_extension}"
                thumbnail_file_path = os.path.join(folder_path, thumbnail_file_name)

                if not os.path.exists(thumbnail_file_path):
                    with Image.open(file_path) as image:
                        image.thumbnail((150, 150))
                        image.save(thumbnail_file_path)

            data = {
                'handle': handle,
                'name': group_name,
                'description': group_description,
                'members': group_members, # change in scrape template
                'avatar': group_photo,
                'logo_path': file_path,
                'thumb_path': thumbnail_file_path
            }

            request.session['data'] = data

            media_form = MediaForm()
            return render(request, self.template_name, {'data': data, 'media_form': media_form})

class HandleGroupFormView(FormView):
    form_class = MediaForm

    def form_valid(self, form):
        data = self.request.session.get('data', None)
        if not data:
            messages.error(self.request, 'No group data found in session.')
        else:
            category = form.cleaned_data.get('category')
            language = form.cleaned_data.get('language')

            category_id = category.id if category else None
            language_id = language.id if language else None

            data.update({
                'body': form.cleaned_data.get('body'),
                'description': form.cleaned_data.get('description'),
                'category_id': category_id,
                'category_name': category.name if category else None,
                'language_id': language_id,
                'nsfw': form.cleaned_data.get('nsfw', False),
                'tags': form.cleaned_data.get('tags'),

            })

            return StoreGroupData.save_data(self.request, data)

class StoreGroupData:
    @staticmethod
    def save_data(request, data):
        category_id = data.get('category_id')
        language_id = data.get('language_id')
        nsfw = data.get('nsfw', False)
        type_id = 2 # hardcoded!
        type_obj = Type.objects.get(id=type_id)

        handle = data['handle']

        try:
            existing_group = Media.objects.get(handle=handle)
            error_message = "Media already exists in the database."
            return render(request, "err.html", {'error_message': error_message})  # ! improve error message
        except ObjectDoesNotExist:
            group = Media.objects.create(
                handle=handle,
                name=data['name'],
                description=data['description'],
                logo_path=data['logo_path'],
                thumb_path=data['thumb_path'],
                body=data['body'],
                category_id=category_id,
                language_id=language_id,
                type=type_obj,
                nsfw=nsfw
            )

        group.tags.add(*data['tags'])

        members = int(data['members'].replace(',', ''))

        group_counter = GroupCounter.objects.create(
            group=group,
            members=members,
        )

        return HttpResponse("Data saved successfully.")  # ! add new template for success message