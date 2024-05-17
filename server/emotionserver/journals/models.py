from django.db import models
from django.http import JsonResponse
from transformers import pipeline 
from jsonfield import JSONField

class Journal(models.Model):
    date = models.TextField(null=False)
    time = models.TextField(max_length=8,null=False)
    isPanic = models.BooleanField(default=False)
    thoughts = models.TextField(max_length=5000)
    created = models.DateTimeField(auto_now_add=True)
    

    class Meta: 
        ordering = ['-created']

