from django.urls import path
from . import views

urlpatterns = [
    path('getListOfJournals/', views.JournalAPI.as_view()),
    path('create/', views.CreateJournalAPI.as_view()),
    path('<str:pk>/deleteUpdateEntry/', views.JournalRetrieveUpdateDestroyAPIView.as_view()),
    path('delete/', views.deleteJournal), 
    path('<str:pk>/', views.getJournal),
    
]