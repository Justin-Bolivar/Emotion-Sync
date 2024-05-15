from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('panic/', include("journals.urls") ),
    path('account/', include("account.urls") ),

]
