# 13 q

from django.db.models import Count, Sum, F
from collections import defaultdict

class MediaIndex(ListView):
    model = Media
    template_name = 'media/index.html'
    context_object_name = 'media_list'
    paginate_by = 200

    def get_queryset(self):
        return Media.objects.select_related('category').all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['channels'], context['groups'] = self.get_channels_and_groups()
        self.add_counters(context, context['media_list'])
        self.add_counters(context, context['channels'])
        self.add_counters(context, context['groups'])
        return context

    def get_channels_and_groups(self):
        channels = Media.objects.select_related('category').filter(type__title='Channels')
        groups = Media.objects.select_related('category').filter(type__title='Groups')
        return channels, groups

    def add_counters(self, context, objects):
        object_ids = [obj.id for obj in objects]
        
        channel_counters = defaultdict(int)
        group_counters = defaultdict(int)

        for counter in ChannelCounter.objects.filter(channel_id__in=object_ids).only('channel_id', 'subscribers'):
            channel_counters[counter.channel_id] = counter.subscribers
        
        for counter in GroupCounter.objects.filter(group_id__in=object_ids).only('group_id', 'members'):
            group_counters[counter.group_id] = counter.members

        for obj in objects:
            obj.counter = channel_counters[obj.id] + group_counters[obj.id]


# 11 q

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


# q 5

from django.db.models import Count, Sum, F
from collections import defaultdict

class MediaIndex(ListView):
    model = Media
    template_name = 'media/index.html'
    context_object_name = 'media_list'
    paginate_by = 200

    def get_queryset(self):
        return Media.objects.select_related('category').all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['channels'], context['groups'] = self.get_channels_and_groups()
        return context

    def get_channels_and_groups(self):
        channels = Media.objects.select_related('category').filter(type__title='Channels')
        groups = Media.objects.select_related('category').filter(type__title='Groups')
        return channels, groups