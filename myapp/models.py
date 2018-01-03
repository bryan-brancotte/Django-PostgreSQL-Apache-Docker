from django.urls import reverse
from django.db import models

class Author(models.Model):
    name = models.CharField(max_length=200)

    def get_absolute_url(self):
        return reverse('myapp:author-detail', kwargs={'pk': self.pk})

    def __str__(self):
        return self.name