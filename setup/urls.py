from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

from items.views import (
  ItemsListView, 
  ItemsCreateView, 
  ItemsUpdateView, 
  ItemsDeleteView,
  ItemsCompleteView,
  ItemsStockView
)

urlpatterns = [
  path("", ItemsListView.as_view(template_name="items/items_main.html"), name="items_main"),
  path('login/', auth_views.LoginView.as_view(template_name='registration/login.html'), name='login'),
  path('logout/', auth_views.LogoutView.as_view(template_name='todos/templates/registration/logged_out.html'), name='logout'),
  path('stock/', ItemsStockView.as_view(), name="items_stock"),
  path("create/", ItemsCreateView.as_view(), name="items_create"),
  path("update/<int:pk>", ItemsUpdateView.as_view(), name="items_update"),
  path("delete/<int:pk>", ItemsDeleteView.as_view(), name="items_delete"),
  path("complete/<int:pk>", ItemsCompleteView.as_view(), name="items_complete"),

]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
