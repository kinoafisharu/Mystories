from rest_framework.generics import ListAPIView

from .serializers import StorySerializer
from ..models import Story


class StoryListAPIView(ListAPIView):

    serializer_class = StorySerializer
    queryset = Story.objects.all()
