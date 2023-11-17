# urls.py
from django.urls import path
from .views import ScrapeDataView, SuccessView, MediaIndex, MediaDetailView, CategoryListView, CategoryDetailView, LanguageListView, LanguageDetailView, TypeListView, TypeDetailView

urlpatterns = [
    # Scrape

    path('', ScrapeDataView.as_view(), name='scrape_data'),
    path('success/', SuccessView.as_view(), name='success'),

    
    # Media 
    path('dir/', MediaIndex.as_view(), name='media'), #media/dir
    path('<slug:type>/<slug:handle>/', MediaDetailView.as_view(), name='media_detail'),

    path('categories/', CategoryListView.as_view(), name='category_list'),
    path('category/<slug:slug>/', CategoryDetailView.as_view(), name='category_detail'),
    
    
    
    path('languages/', LanguageListView.as_view(), name='language-list'),
    path('languages/<slug:slug>/', LanguageDetailView.as_view(), name='language-detail'),
    path('types/', TypeListView.as_view(), name='type-list'),
    path('type/<slug:slug>/', TypeDetailView.as_view(), name='type-detail'),
]