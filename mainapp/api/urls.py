from django.urls import path
from .api_views import StoryListAPIView

urlpatterns = [
    path('', StoryListAPIView.as_view(), name='main_page'),
]
