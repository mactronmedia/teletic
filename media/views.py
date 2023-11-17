import qrcode
from django.db.models import Sum
from django.views import View
from django.views.generic.edit import FormView, FormMixin

from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.views.decorators.cache import never_cache

from django.views.generic import TemplateView, ListView, DetailView
 
from django.core.paginator import Paginator
from django.db.models import Q, F
from django.db.models.functions import Random # randomly shows post
from django.shortcuts import render, redirect, get_object_or_404
from .models import Media, Category, Language, Type, ChannelCounter, GroupCounter
from .channels import ScrapeChannelDataView
from .groups import ScrapeGroupDataView
from .bots import ScrapeBotDataView
from .forms import CommentForm, HandleForm, PageUrlForm


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

        return render(request, 'media/category_list.html', {'categories': categories})


class CategoryDetailView(DetailView):
    model = Category
    template_name = 'media/category_detail.html'
    context_object_name = 'category'

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
 

class MediaDetailView(FormMixin, DetailView):
    model = Media
    template_name = 'media/media_detail.html'
    context_object_name = 'media'
    form_class = CommentForm

    def get_object(self, queryset=None):
        if queryset is None:
            queryset = self.get_queryset()
        type_slug = self.kwargs.get('type_slug')
        media_slug = self.kwargs.get('media_slug')
        return get_object_or_404(queryset, type__slug=type_slug, handle=media_slug)

    def get_queryset(self):
        return Media.objects.filter(status__in=[0, 1], language__slug="en").select_related().all().annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        )

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        media = self.object
        context.update(self.get_media_counters(media))
        context['tags'] = media.tags.all()
        context['comment_form'] = self.get_form()
        context['qr_code_image_path'] = self.generate_qr_code(media)
        return context

    def get_media_counters(self, media):
        counters = {
            'subscribers': 0,
            'photos': 0,
            'videos': 0,
            'files': 0,
            'links': 0,
            'members': 0,
        }

        if media.type.slug == 'channels':
            channel_counter = ChannelCounter.objects.filter(channel=media).first()
            if channel_counter:
                counters.update({
                    'subscribers': channel_counter.subscribers,
                    'photos': channel_counter.photos,
                    'videos': channel_counter.videos,
                    'files': channel_counter.files,
                    'links': channel_counter.links,
                })

        if media.type.slug == 'groups':
            group_counter = GroupCounter.objects.filter(group=media).first()
            if group_counter:
                counters['members'] = group_counter.members

        return counters

    def generate_qr_code(self, media):
        qr_code = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=5,
            border=4,
        )
        qr_code.add_data(f"tg://resolve?domain={media.handle}")
        qr_code.make(fit=True)
        qr_code_image = qr_code.make_image(fill_color="black", back_color="white")

        qr_code_image_path = f'storage/qr_codes/{media.handle}_qr_code.png'
        qr_code_image.save(qr_code_image_path)
        return qr_code_image_path

    def post(self, request, *args, **kwargs):
        media = self.get_object()
        comment_form = CommentForm(request.POST)

        if comment_form.is_valid():
            comment = comment_form.save(commit=False)
            comment.media = media
            comment.user = self.request.user
            comment.save()
            return redirect('media_detail', type_slug=media.type.slug, media_slug=media.handle)
        else:
            context = self.get_context_data()
            context['comment_form'] = comment_form
            return self.render_to_response(context)

    def link_view(self, request):
        link_form = PageUrlForm()
        context = {'link_form': link_form}
        return self.render_to_response(context)

class MediaIndexView(ListView):
    template_name = 'index.html'
    context_object_name = 'media_list'
    paginate_by = 500

    # Cache entire page
    #@method_decorator(cache_page(60 * 15)) # cache for 15 minutes
    #def dispatch(self, *args, **kwargs):
    #    return super().dispatch(*args, **kwargs)

    def get_queryset(self):
        queryset = Media.objects.filter(status__in=[0, 1], language__slug="en").select_related().all()
        queryset = queryset.annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        ).order_by(Random())  # Randomize the order of items

        return queryset
        
    def get_latest_media(self):
        latest_media = Media.objects.filter(status__in=[0, 1], language__slug="en").select_related() 
        latest_media = latest_media.annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        ).order_by('-published_at')  # Order by created_at in descending order to get the latest first


        return latest_media

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        all_media = self.object_list
        context['channels'] = all_media.filter(type__slug='channels', language__slug="en")[:8] #numbers of channels to display
        context['groups'] = all_media.filter(type__slug='groups', language__slug="en")[:8]
        context['bots'] = all_media.filter(type__slug='bots', language__slug="en")[:8] 
        context['latest_media'] = self.get_latest_media()[:4]

        return context


class ChannelIndexView(ListView):
    template_name = 'media/channels_index.html'
    context_object_name = 'media_list'
    paginate_by = 50

    def get_queryset(self):
        queryset = Media.objects.filter(status__in=[0, 1], type__slug='channels', language__slug="en").select_related().all().order_by('-published_at')

        queryset = queryset.annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        )

        return queryset


class GroupIndexView(ListView):
    template_name = 'media/groups_index.html'
    context_object_name = 'media_list'
    paginate_by = 50

    def get_queryset(self):
        queryset = Media.objects.filter(status__in=[0, 1], type__slug='groups', language__slug="en").select_related().all().order_by('-published_at')

        queryset = queryset.annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        )

        return queryset


class BotIndexView(ListView):
    template_name = 'media/bots_index.html'
    context_object_name = 'media_list'
    paginate_by = 50

    def get_queryset(self):
        queryset = Media.objects.filter(status__in=[0, 1], type__slug='bots', language__slug="en").select_related().all().order_by('-published_at')

        queryset = queryset.annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        )

        return queryset

# for latest page list of media
class LatestMediaListView(ListView):
    model = Media
    template_name = 'media/latest_page.html'
    context_object_name = 'latest_media'
    paginate_by = 100 # Adjust the number of items per page as needed

    def get_queryset(self):
        queryset = Media.objects.filter(status__in=[0, 1], language__slug="en").select_related().all()
        queryset = queryset.annotate(
            subscribers_count=F('channelcounter__subscribers'),
            members_count=F('groupcounter__members')
        ).order_by('-published_at')  # Order by created_at in descending order to get the latest first

        return queryset

class TopMediaListView(ListView):
    model = Media
    template_name = 'media/top.html'
    context_object_name = 'top_media'





