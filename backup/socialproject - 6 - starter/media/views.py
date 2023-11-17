from django.db.models import Sum
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
       

from random import shuffle

class MediaIndex(ListView):
    model = Media
    template_name = 'media/index.html'
    context_object_name = 'media_list'
    paginate_by = 200

    def get_queryset(self):
        queryset = Media.objects.filter(status__in=[0, 1, 2, 3]).select_related('category').all().annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        )
        
        queryset_list = list(queryset)
        shuffle(queryset_list)
        return queryset_list

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        media = Media()
        channels, groups, bots = media.get_channels_groups_bots()

        channel_subscriber_mapping = media.get_channel_subscriber_mapping(channels)
        group_member_mapping = media.get_group_member_mapping(groups)

        context.update(media.get_media_context(channels, groups, bots, channel_subscriber_mapping, group_member_mapping))

        return context


 