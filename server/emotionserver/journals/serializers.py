from rest_framework.serializers import ModelSerializer
from .models import Journal
from .emotion import getEmotion
from rest_framework import serializers


class JournalSerializer(ModelSerializer):
    emotions = serializers.SerializerMethodField(read_only=True, required=False)
    class Meta:
        model = Journal
        fields = '__all__'
    def get_emotions(self, obj):
        thoughts = obj.thoughts
        emotions = getEmotion(thoughts)
        return emotions

# class EmotionSerializer(serializers.ModelSerializer):
#     emotions = serializers.SerializerMethodField(read_only=True, required=False)
#     class Meta:
#         model = Journal
#         fields = ('id', 'thoughts', 'emotions')
#     def get_emotions(self, obj):
#         thoughts = obj.thoughts
#         emotions = getEmotion(thoughts)
#         return emotions