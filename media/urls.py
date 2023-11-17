# urls.py
from django.urls import path
from .views import ScrapeDataView, SuccessView, MediaIndexView, CategoryListView, MediaDetailView, ChannelIndexView, GroupIndexView, BotIndexView, LatestMediaListView, TopMediaListView, CategoryListView, CategoryDetailView, LanguageListView, LanguageDetailView, TypeListView, TypeDetailView


urlpatterns = [
    path('add/', ScrapeDataView.as_view(), name='scrape_data'), # add media
    path('success/', SuccessView.as_view(), name='success'), # view once media is added

    
    # Media 
    path('', MediaIndexView.as_view(), name='media'), 
    path('latest/', LatestMediaListView.as_view(), name='media_detail'),
    path('channels/', ChannelIndexView.as_view(), name='media_detail'),
    path('groups/', GroupIndexView.as_view(), name='media_detail'),
    path('bots/', BotIndexView.as_view(), name='media_detail'),

    path('top/', TopMediaListView.as_view(), name='media_detail'),


    #path('categories/', CategoryListView.as_view(), name='category_list'),
    path('categories/', CategoryListView.as_view(), name='category-list'),
    path('category/<slug:slug>/', CategoryDetailView.as_view(), name='category_detail'),

    
    path('languages/', LanguageListView.as_view(), name='language-list'),
    path('languages/<slug:slug>/', LanguageDetailView.as_view(), name='language_detail'),

    path('types/', TypeListView.as_view(), name='type_list'),
    path('type/<slug:slug>/', TypeDetailView.as_view(), name='type_detail'),


    # Media Details
    path('<slug:type_slug>/<slug:media_slug>/', MediaDetailView.as_view(), name='media_detail'),


]