from rest_framework import serializers
from ..models import Story


class StorySerializer(serializers.ModelSerializer):

    title = serializers.CharField(required=True)
    announce = serializers.CharField(required=True)
    text = serializers.CharField(required=True)
    # author = serializers.CharField(required=True) # TODO: Create bound and Model
    publish_time = serializers.CharField(required=True)

    class Meta:
        model = Story
        fields = "__all__"
