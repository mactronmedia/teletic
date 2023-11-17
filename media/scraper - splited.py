import os
import re
import requests
from datetime import datetime
from urllib.parse import urlparse
from django.conf import settings

from PIL import Image
from bs4 import BeautifulSoup
from fake_useragent import UserAgent
from .models import Media, Category, Language, Type, ChannelCounter

session = requests.Session()
user_agent = UserAgent()

def scrape_channel_data(handle):
    url = f"https://t.me/{handle}"
    headers = {"User-Agent": user_agent.random}
    page = session.get(url, headers=headers)
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

    channel_avatar = soup.find("meta", attrs={"property": "og:image"})["content"]
    file_path, thumbnail_file_path = download_avatar(handle, channel_avatar)

    data = {
        "handle": handle,
        "name": channel_name,
        "description": channel_description,
        "subscribers": channel_subscribers,
        "avatar": channel_avatar,
        "logo_path": file_path,
        "thumb_path": thumbnail_file_path,
    }         
    
    return data

def scrape_created_date(handle):
    url = f"https://t.me/s/{handle}/1"
    headers = {"User-Agent": user_agent.random}
    page = session.get(url, headers=headers)
    soup = BeautifulSoup(page.content, "lxml")

    channel_start_date = soup.find('time')

    if channel_start_date:
        datetime_string = channel_start_date['datetime']
        date_object = datetime.fromisoformat(datetime_string).date()

        # Format the date as text in the desired format
        channel_created = date_object.strftime("%Y-%m-%d")
        nice_date_text = date_object.strftime("%B %d, %Y")

        print(channel_created)

        created = {
            "date": channel_created,
        }

        return created


def scrape_counter_data(handle):
    url = f"https://t.me/s/{handle}"
    headers = {"User-Agent": user_agent.random}
    page = session.get(url, headers=headers)
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

def download_avatar(handle, channel_avatar):
    file_path = settings.LOGO_PHOTO  # * SETTINGS
    thumbnail_file_path = settings.THUMBNAIL_PHOTO  # * SETTINGS

    if ".jpg" in channel_avatar:
        current_month = datetime.now().month
        directory = f"{current_month:02d}"
        folder_path = os.path.join("storage/channels", directory)
        os.makedirs(folder_path, exist_ok=True)

        parsed_url = urlparse(channel_avatar)
        file_extension = os.path.splitext(parsed_url.path)[1][1:]
        new_file_name = f"{handle}_logo.{file_extension}"
        file_path = os.path.join(folder_path, new_file_name)

        if not os.path.exists(file_path):
            image_data = requests.get(channel_avatar).content
            with open(file_path, "wb") as image_file:
                image_file.write(image_data)

        thumbnail_file_name = f"{handle}_thumb.{file_extension}"
        thumbnail_file_path = os.path.join(folder_path, thumbnail_file_name)

        if not os.path.exists(thumbnail_file_path):
            with Image.open(file_path) as image:
                image.thumbnail((150, 150))
                image.save(thumbnail_file_path)

    return file_path, thumbnail_file_path

def save_data(request, handle, data, created, counter):
    category_id = data.get("category_id")
    language_id = data.get("language_id")
    nsfw = data.get("nsfw", False)
    type_id = 1  # ! hardcoded

    channel_created = created.get("date") if created else None

    channel = Media.objects.create(
        handle=handle,
        name=data["name"],
        description=data["description"],
        logo_path=data["logo_path"],
        thumb_path=data["thumb_path"],
        body=data.get("body", ""),  # Ensure 'body' key is present in data dictionary
        category_id=category_id,
        language_id=language_id,
        type_id=type_id,
        nsfw=nsfw,
        created_at=channel_created,
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
        files=files,
        videos=videos,
        links=links,
    )






