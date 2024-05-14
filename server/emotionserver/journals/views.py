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
    isPanic = request.data.get('isPanic', '')
    thoughts = request.data.get('thoughts', '')
    created = request.data.get('created', '')

    analysis_result = models.Journal.objects.create(
        date=date,
        time=time,
        isPanic=isPanic,
        thoughts=thoughts,
        created=created,
    )

    serializer = JournalSerializer(analysis_result)
        
    return Response(serializer.data, status=status.HTTP_201_CREATED)

    # if serializer.is_valid(raise_exception=True):
    #     entry=serializer.save()
    #     return Response(JournalSerializer(entry,many=False).data)
    # return Response({})



class CreateJournalAPI(CreateAPIView):
    serializer_class = JournalSerializer


#for returning list of journals (used in homepage)
class JournalAPI(ListCreateAPIView): 
    serializer_class=JournalSerializer
    queryset = Journal.objects.all()

    def get_queryset(self):
        queryset=Journal.objects.all()
        return queryset


# as the name suggests, for retrieve & destroy
class JournalRetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    serializer_class = JournalSerializer
    queryset = Journal.objects.all()
    lookup_field = 'pk'
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = JournalSerializer(instance)
        return Response(serializer.data)

    # def update(self, request, *args, **kwargs):
    #     partial = kwargs.pop('partial', False)
    #     instance = self.get_object()
    #     serializer = self.get_serializer(instance, data=request.data, partial=partial)
    #     serializer.is_valid(raise_exception=True)
    #     instance=serializer.save()
    #     serializer = JournalSerializer(instance)

    #     if getattr(instance, '_prefetched_objects_cache', None):
    #         # If 'prefetch_related' has been applied to a queryset, we need to
    #         # forcibly invalidate the prefetch cache on the instance.
    #         instance._prefetched_objects_cache = {}

    #     return Response(serializer.data)



def getJournal(request):
    pass
def getListOfEntries(request):
    pass
def updateJournal(request):
    pass

def deleteJournal(request):
    pass


# py manage.py makemigrations
# py manage.py migrate