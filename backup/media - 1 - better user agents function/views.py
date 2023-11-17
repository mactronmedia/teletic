from django.http import HttpResponse
from django.views import View
from django.views.generic import TemplateView, ListView, DetailView
from django.core.paginator import Paginator
from django.db.models import Q, F
from django.shortcuts import render, get_object_or_404
from .models import Media, Category, Language, Type, ChannelCounter
from .channels import ScrapeChannelDataView
from .groups import ScrapeGroupDataView
from .bots import ScrapeBotDataView

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

# Use ListView for MediaIndex
class MediaIndex(ListView):
    model = Media
    template_name = 'list.html'
    context_object_name = 'page_obj'
    paginate_by = 20

    def get_queryset(self):
        media = super().get_queryset().filter(status__in=[0, 1, 2, 3])

        search_query = self.request.GET.get('search')
        if search_query:
            media = media.filter(Q(name__icontains=search_query) | Q(description__icontains=search_query))
        else:
            media = media.order_by('?')  # Randomly order the media only for the index

        return media

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        media_ids = [m.id for m in context['page_obj']]

        # Fetch channel counters using prefetch_related()
        counters = ChannelCounter.objects.filter(channel_id__in=media_ids).prefetch_related('channel')

        # Create a dictionary comprehension to store the counter values
        counter_values = {
            counter.channel_id: {
                'subscribers': counter.subscribers,
                'photos': counter.photos,
                'videos': counter.videos,
                'files': counter.files,
                'links': counter.links
            }
            for counter in counters
        }

        # Add the counter values to the media objects in the page_obj
        for media_obj in context['page_obj']:
            counters = counter_values.get(media_obj.id, {})
            media_obj.subscribers = counters.get('subscribers')
            media_obj.photos = counters.get('photos')
            media_obj.videos = counters.get('videos')
            media_obj.files = counters.get('files')
            media_obj.links = counters.get('links')

        return context