import os
from django.shortcuts import render, redirect
from django.views import View
from django.views.generic import FormView
from django.contrib import messages
from django.urls import reverse
from django.utils.safestring import mark_safe

from .forms import MediaForm
from .models import Media, Category, Language, Type, ChannelCounter
from .scraper import ChannelScraper, SaveChannelData

class ScrapeChannelDataView(View):
    template_name = "scrape.html"
    channel_scraper = ChannelScraper()  # Create an instance of the Scraper class

    def get(self, request):
        media_form = MediaForm()
        return render(request, self.template_name, {"media_form": media_form})

    def post(self, request, handle=None):  # Added handle=None as a default value
        # Check if the form submit button was clicked
        if "handle_form_submit" in request.POST:
            form_view = HandleChannelFormView.as_view()
            return form_view(request)
        handle = handle.lower()
        return self.channel_exists(request, handle)

    def channel_exists(self, request, handle):
        try:
            Media.objects.get(handle=handle)
            # ! hardcoded
            error_message = mark_safe(f'Channel @<a href="http://localhost:8000/channels/{handle}/">{handle}</a> already exists in the database.')

            return render(request, self.template_name, {"error_message": error_message})
        except Media.DoesNotExist:
            channel_data = self.channel_scraper.scrape_channel_data(handle)

            if "error_message" in channel_data:  # Check if an error message was returned
                return render(request, self.template_name, {"error_message": channel_data["error_message"]})

            created_date = self.channel_scraper.scrape_created_date(handle)  # new
            counter_data = self.channel_scraper.scrape_counter_data(handle)

            request.session["data"] = channel_data
            request.session["created"] = created_date
            request.session["counter"] = counter_data

            media_form = MediaForm()
            return render(
                request,
                self.template_name,
                {
                    "data": channel_data,
                    "created": created_date,
                    "counter": counter_data,
                    "media_form": media_form,
                },
            )

class HandleChannelFormView(FormView):
    form_class = MediaForm
    success_url = "/success/"
    save_channel_data = SaveChannelData()  # Create an instance of the Scraper class

    def form_valid(self, form):
        data = self.request.session.get("data", {})
        if not data:
            messages.error(self.request, "No channel data found in session.")
            return redirect(reverse("media"))

        created = self.request.session.get("created", {})
        counter = self.request.session.get("counter", {})

        handle = data.get("handle")  # Retrieve the handle from the data

        category = form.cleaned_data.get("category")
        language = form.cleaned_data.get("language")
        category_id = category.id if category else None
        language_id = language.id if language else None

        # Update the 'data' dictionary with the provided values
        data.update({
            "body": form.cleaned_data.get("body"),
            "description": form.cleaned_data.get("description"),
            "category_id": category_id,
            "category_name": category.name if category else None,
            "language_id": language_id,
            "nsfw": form.cleaned_data.get("nsfw", False),
            "tags": form.cleaned_data.get("tags"),
        })

        self.save_channel_data.save_data(self.request, handle, data, created, counter)  # Pass 'handle', 'data', 'created', and 'counter'
        return redirect(self.get_success_url())