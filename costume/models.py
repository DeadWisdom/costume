from django.db import models
from django.contrib.sessions.models import Session


class Card(models.Model):
    text = models.CharField(max_length=255)
    session = models.ForeignKey(Session, blank=True, null=True)
    used = models.DateTimeField(blank=True, null=True)
    order = models.PositiveIntegerField(blank=True, null=True)
    #deleted = models.BooleanField(default=False)

    def __unicode__(self):
        return self.text

    def is_image(self):
        return self.text.startswith("http")