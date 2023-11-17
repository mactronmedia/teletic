from django.http import HttpResponse
from django.views import View
from django.views.generic import TemplateView, ListView, DetailView
from django.core.paginator import Paginator
from django.db.models import Q, F
from django.shortcuts import render, get_object_or_404
from .models import Media, Category, Language, Type, ChannelCounter, GroupCounter
from .channels import ScrapeChannelDataView
from .groups import ScrapeGroupDataView
from .bots import ScrapeBotDataView
 
import random
# Use TemplateView for NotFoundView
class NotFoundView(TemplateView):
    template_name = '404.html'
    status_code = 404

    def render_to_response(self, context, **response_kwargs):
        response_kwargs.setdefault('content_type', self.content_type)
        return self.response_class(
            request=self.request,
            template=self.get_template_names(),
            context=context,
            **response_kwargs
        )

# Use Django's built-in FormView for ScrapeDataView
class ScrapeDataView(TemplateView):
    template_name = 'scrape.html'

    def post(self, request, *args, **kwargs):
        function = request.POST.get('function')
        handle = request.POST.get('handle')

        if function == 'channel':
            scrape_view = ScrapeChannelDataView()
        elif function == 'group':
            scrape_view = ScrapeGroupDataView()
        elif function == 'bot':
            scrape_view = ScrapeBotDataView()
        else:
            return self.render_to_response(self.get_context_data())

        return scrape_view.post(request, handle)

# for redirect after media has been added!
class SuccessView(TemplateView):
    template_name = 'success.html'

# Use ListView for CategoryListView
# Index and DetailView for Category
class CategoryListView(ListView):
    def get(self, request, category_slug=None):
        categories = Category.objects.all()

        return render(request, 'category_list.html', {'categories': categories})

class CategoryDetailView(DetailView):
    model = Category
    template_name = 'category_detail.html'
    context_object_name = 'category'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        category = self.get_object()
        media = Media.objects.filter(category=category)
        context['media_list'] = media
        return context

# Use ListView for LanguageListView
class LanguageListView(ListView):
    model = Language
    template_name = 'language_list.html'
    context_object_name = 'languages'

# Use DetailView for LanguageDetailView
class LanguageDetailView(DetailView):
    model = Language
    template_name = 'language_detail.html'
    context_object_name = 'language'

# Use ListView for TypeListView
class TypeListView(ListView):
    model = Type
    template_name = 'type_list.html'
    context_object_name = 'types'

# Use DetailView for TypeDetailView
class TypeDetailView(DetailView):
    model = Type
    template_name = 'type_detail.html'
    context_object_name = 'type'

# Use DetailView for MediaDetailView
class MediaDetailView(DetailView):
    model = Media
    template_name = 'media_detail.html'
    slug_url_kwarg = 'handle'
    slug_field = 'handle'
    #queryset = Media.objects.select_related('category')  # Use select_related to fetch related category

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        media = self.get_object()

        # Retrieve the ChannelCounter object related to the media
        channel_counter = ChannelCounter.objects.filter(channel=media).first()

        # Add relevant data to the context dictionary
        context['subscribers'] = channel_counter.subscribers if channel_counter else 0
        context['photos'] = channel_counter.photos if channel_counter else 0
        context['videos'] = channel_counter.videos if channel_counter else 0
        context['files'] = channel_counter.files if channel_counter else 0
        context['links'] = channel_counter.links if channel_counter else 0

        # Add tags to the context dictionary
        context['tags'] = media.tags.all()
        
        return context

 

# 5



class MediaIndex(ListView):
    model = Media
    template_name = 'media/index.html'
    context_object_name = 'media_list'
    paginate_by = 200

    def get_queryset(self):
        return Media.objects.select_related('category').all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['channels'] = self.get_channels()
        context['groups'] = self.get_groups()
        self.add_counters_to_media(context)
        return context

    def get_channels(self):
        return Media.objects.select_related('category').filter(type__title='Channels')

    def get_groups(self):
        return Media.objects.select_related('category').filter(type__title='Groups')

 
class MediaIndex(ListView):
    model = Media
    template_name = 'media/index.html'
    context_object_name = 'media_list'
    paginate_by = 200

    def get_queryset(self):
        return Media.objects.select_related('category').all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['channels'] = self.get_channels()
        context['groups'] = self.get_groups()
        self.add_counters_to_media(context)
        self.add_counters_to_channels(context)
        self.add_counters_to_groups(context)
        return context

    def get_channels(self):
        return Media.objects.select_related('category').filter(type__title='Channels')

    def get_groups(self):
        return Media.objects.select_related('category').filter(type__title='Groups')

    def add_counters_to_media(self, context):
        media_objects = context['page_obj']
        media_ids = [media_obj.id for media_obj in media_objects]

        channel_counter_values = {
            counter.channel_id: counter.subscribers
            for counter in ChannelCounter.objects.filter(channel_id__in=media_ids).only('channel_id', 'subscribers')
        }

        group_counter_values = {
            counter.group_id: counter.members
            for counter in GroupCounter.objects.filter(group_id__in=media_ids).only('group_id', 'members')
        }

        for media_obj in media_objects:
            media_obj.counter = channel_counter_values.get(media_obj.id, 0) + group_counter_values.get(media_obj.id, 0)

    def add_counters_to_channels(self, context):
        channels = context['channels']
        channel_ids = [channel.id for channel in channels]

        channel_counter_values = {
            counter.channel_id: counter.subscribers
            for counter in ChannelCounter.objects.filter(channel_id__in=channel_ids).only('channel_id', 'subscribers')
        }

        for channel in channels:
            channel.counter = channel_counter_values.get(channel.id, 0)

    def add_counters_to_groups(self, context):
        groups = context['groups']
        group_ids = [group.id for group in groups]

        group_counter_values = {
            counter.group_id: counter.members
            for counter in GroupCounter.objects.filter(group_id__in=group_ids).only('group_id', 'members')
        }

        for group in groups:
            group.counter = group_counter_values.get(group.id, 0)