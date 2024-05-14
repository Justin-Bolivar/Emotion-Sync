from django.db import models
from django.http import JsonResponse
from transformers import pipeline 
from jsonfield import JSONField

class Journal(models.Model):
    date = models.TextField(null=False) #data to be fetched from flutter
    time = models.TextField(max_length=8,null=False)
    isPanic = models.BooleanField(default=False)
    # panicDuration to be added
    thoughts = models.TextField(max_length=5000)
    created = models.DateTimeField(auto_now_add=True)
    

    # emotion analysis part

    # def save(self, *args, **kwargs):
    #     # Call the getEmotion function and store its result in the emotion field
    #     self.emotion = self.getEmotion(self.text)
    #     super().save(*args, **kwargs) # Call the "real" save() method

    # @staticmethod
    # def getEmotion(text):
    #     classifier = pipeline(task="text-classification", model="SamLowe/roberta-base-go_emotions", top_k=None)
    #     model_outputs = classifier(text)

    #     # Assuming you want to store the first emotion label from the model's output
    #     return model_outputs[0]['label'] if model_outputs else None
    
    
    class Meta: 
        ordering = ['-created']


# class Emotion(models.Model):
#     date = models.TextField(null=False) #data to be fetched from flutter
#     time = models.TextField(max_length=8,null=False)
#     isPanic = models.BooleanField(default=False)
#     # panicDuration to be added
#     thoughts = models.TextField(max_length=5000)
#     created = models.DateTimeField(auto_now_add=True)
    