from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from .emotion import getEmotion
from .models import Journal
from .serializers import JournalSerializer
from rest_framework.generics import (CreateAPIView ,
                                     UpdateAPIView,
                                     DestroyAPIView,
                                     ListAPIView,
                                     RetrieveUpdateDestroyAPIView,
                                     ListCreateAPIView
                                     )

from . import models


# Journal creation
@api_view(["POST"])
def createJournal(request):
    # data=request.data.dict()
    # print(data)
    # serializer=JournalSerializer(data=data) 

    # libog na part:
    date = request.data.get('date', '')
    time = request.data.get('time', '')
    thoughts = request.data.get('thoughts', '')
    created = request.data.get('created', '')

    analysis_result = models.Journal.objects.create(
        date=date,
        time=time,
        thoughts=thoughts,
        created=created,
    )

    serializer = JournalSerializer(analysis_result)
        
    return Response(serializer.data, status=status.HTTP_201_CREATED)



class CreateJournalAPI(CreateAPIView):
    serializer_class = JournalSerializer


#for returning list of journals (used in homepage)
class JournalAPI(ListCreateAPIView): 
    serializer_class=JournalSerializer
    queryset = Journal.objects.all()

    def get_queryset(self):
        queryset=Journal.objects.all()
        return queryset



class JournalRetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    serializer_class = JournalSerializer
    queryset = Journal.objects.all()
    lookup_field = 'pk'
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = JournalSerializer(instance)
        return Response(serializer.data)



# py manage.py makemigrations
# py manage.py migrate