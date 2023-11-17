import os
import re
import requests
from datetime import datetime
from urllib.parse import urlparse

from PIL import Image
from bs4 import BeautifulSoup
from fake_useragent import UserAgent

from django import http
from django.conf import settings
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.http import HttpResponse
from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse
from django.views import View
from django.views.generic import FormView

from .forms import MediaForm
from .models import Media, Category, Language, Type, ChannelCounter
from taggit.models import Tag


class ScrapeChannelDataView(View):
    template_name = "scrape.html"
    session = requests.Session()
    user_agent = UserAgent()

    def get(self, request):
        media_form = MediaForm()
        return render(request, self.template_name, {"media_form": media_form})

    def post(self, request, handle):
        if "handle_form_submit" in request.POST:
            form_view = HandleChannelFormView.as_view()
            return form_view(request)
        handle = handle.lower()

        return self.scrape_channel_data(request, handle)

    def scrape_channel_data(self, request, handle):
        try:
            Media.objects.get(handle=handle)
            error_message = "Media already exists in the database."
            return render(request, self.template_name, {"error_message": error_message})
        except Media.DoesNotExist:
            channel_data = self.get_channel_data(handle)

            if "error_message" in channel_data:  # Check if an error message was returned
                return render(request, self.template_name, {"error_message": channel_data["error_message"]})

            counter_data = self.get_counter_data(handle)

            request.session["data"] = channel_data
            request.session["counter"] = counter_data

            media_form = MediaForm()
            return render(
                request,
                self.template_name,
                {
                    "data": channel_data,
                    "counter": counter_data,
                    "media_form": media_form,
                },
            )

    def get_channel_data(self, handle):
        url = f"https://t.me/{handle}"
        headers = {"User-Agent": self.user_agent.random}

        print("User-Agent Header:", headers["User-Agent"])  # Print the user agent

        page = self.session.get(url, headers=headers)
        soup = BeautifulSoup(page.content, "lxml")

        channel_name = soup.find("span", attrs={"dir": "auto"})
        channel_name = channel_name.text.strip() if channel_name else ""
        channel_name = re.sub(r"[^\w\s\d]|_", "", channel_name)  # remove emojis

        channel_description = soup.find("div", attrs={"class": "tgme_page_description"})
        channel_description = (" ".join(channel_description.stripped_strings) if channel_description else "")

        channel_subscribers = soup.find("div", attrs={"class": "tgme_page_extra"})
        if channel_subscribers is None or "subscribers" not in channel_subscribers.text:
            error_message = "Subscribers not found. Wrong media!"
            return {"error_message": error_message}

        channel_subscribers = channel_subscribers.text.strip()
        channel_subscribers = re.sub("[^0-9]", "", channel_subscribers)
        channel_subscribers = "{:,}".format(int(channel_subscribers))  # add comma to the numbers ex: 1,000

        channel_photo = soup.find("meta", attrs={"property": "og:image"})["content"]
        file_path, thumbnail_file_path = self.download_photo(handle, channel_photo)

        data = {
            "handle": handle,
            "name": channel_name,
            "description": channel_description,
            "subscribers": channel_subscribers,
            "avatar": channel_photo,
            "logo_path": file_path,
            "thumb_path": thumbnail_file_path,
        }         
            
        return data

    def download_photo(self, handle, channel_photo):
        file_path = settings.LOGO_PHOTO
        thumbnail_file_path = settings.THUMBNAIL_PHOTO

        if ".jpg" in channel_photo:
            current_month = datetime.now().month
            directory = f"{current_month:02d}"
            folder_path = os.path.join("storage/channels", directory)
            os.makedirs(folder_path, exist_ok=True)

            parsed_url = urlparse(channel_photo)
            file_extension = os.path.splitext(parsed_url.path)[1][1:]
            new_file_name = f"{handle}_logo.{file_extension}"
            file_path = os.path.join(folder_path, new_file_name)

            if not os.path.exists(file_path):
                image_data = requests.get(channel_photo).content
                with open(file_path, "wb") as image_file:
                    image_file.write(image_data)

            thumbnail_file_name = f"{handle}_thumb.{file_extension}"
            thumbnail_file_path = os.path.join(folder_path, thumbnail_file_name)

            if not os.path.exists(thumbnail_file_path):
                with Image.open(file_path) as image:
                    image.thumbnail((150, 150))
                    image.save(thumbnail_file_path)

        return file_path, thumbnail_file_path

    def get_counter_data(self, handle):
        url = f"https://t.me/s/{handle}"
        headers = {"User-Agent": self.user_agent.random}

        print("User-Agent Header:", headers["User-Agent"])  # Print the user agent

        page = self.session.get(url, headers=headers)
        soup = BeautifulSoup(page.content, "lxml")

        channel_counters = soup.find("div", attrs={"class": "tgme_channel_info_counters"})
        channel_counters = (" ".join(channel_counters.stripped_strings) if channel_counters else "")

        counter = {}
        parts = channel_counters.split()
        counter_mapping = {
            "photos": "photos",
            "photo": "photos",
            "videos": "videos",
            "video": "videos",
            "files": "files",
            "file": "files",
            "links": "links",
            "link": "links",
        }

        for index, part in enumerate(parts):
            if part in counter_mapping:
                counter[counter_mapping[part]] = str(parts[index - 1])

        return counter


class HandleChannelFormView(FormView):
    form_class = MediaForm
    success_url = "/success/"  # URL to redirect after successful form submission

    def form_valid(self, form):
        data = self.request.session.get("data", {})
        if not data:
            messages.error(self.request, "No channel data found in session.")
            return redirect(reverse("media"))  # Redirect back to the scrape page

        category = form.cleaned_data.get("category")
        language = form.cleaned_data.get("language")
        category_id = category.id if category else None
        language_id = language.id if language else None

        data.update(
            {
                "body": form.cleaned_data.get("body"),
                "description": form.cleaned_data.get("description"),
                "category_id": category_id,
                "category_name": category.name if category else None,
                "language_id": language_id,
                "nsfw": form.cleaned_data.get("nsfw", False),
                "tags": form.cleaned_data.get("tags"),
            }
        )

        counter = self.request.session.get("counter", {})
        return StoreChannelData.save_data(self.request, data, counter)


class StoreChannelData:
    @staticmethod
    def save_data(request, data, counter):
        category_id = data.get("category_id")
        language_id = data.get("language_id")
        nsfw = data.get("nsfw", False)
        type_id = 1  # hardcoded!
        type_obj = Type.objects.get(id=type_id)

        handle = data["handle"]

        try:
            channel = Media.objects.get(handle=handle)
            error_message = "Media already exists in the database."
            return render(
                request, "err.html", {"error_message": error_message}
            )  # ! improve error message
        except Media.DoesNotExist:
            channel = Media.objects.create(
                handle=handle,
                name=data["name"],
                description=data["description"],
                logo_path=data["logo_path"],
                thumb_path=data["thumb_path"],
                body=data["body"],
                category_id=category_id,
                language_id=language_id,
                type=type_obj,
                nsfw=nsfw,
            )

            channel.tags.add(*data["tags"])

            subscribers = int(data["subscribers"].replace(",", ""))
            photos = counter.get("photos", "0").replace(",", "")
            videos = counter.get("videos", "0").replace(",", "")
            files = counter.get("files", "0").replace(",", "")
            links = counter.get("links", "0").replace(",", "")

            channel_counter = ChannelCounter.objects.create(
                channel=channel,
                subscribers=subscribers,
                photos=photos,
                videos=videos,
                links=links,
            )

        return redirect(reverse("success"))  # Redirect to a success page after saving the data