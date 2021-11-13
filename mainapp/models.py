from datetime import datetime
from django.db import models


class Story(models.Model):
    objects = None
    title = models.CharField(max_length=255)
    announce = models.CharField(max_length=255)
    text = models.TextField()
    # author =  # TODO: Create bound and Model
    publish_time = models.DateTimeField(default=datetime.now, blank=True)

    def __str__(self):
        return self.title

    # def get_absolute_url(self):  # TODO: Refactor according to relevant url structure
    #     return f"/{self.id}"

    class Meta:
        verbose_name = "История"
        verbose_name_plural = "Истории"
