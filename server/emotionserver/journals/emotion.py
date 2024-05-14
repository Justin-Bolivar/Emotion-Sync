from django.http import JsonResponse
from transformers import pipeline 


classifier = pipeline(task="text-classification", model="SamLowe/roberta-base-go_emotions", top_k=None)

def getEmotion(text):

    model_outputs = classifier(text)
    return model_outputs