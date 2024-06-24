from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

from todos.views import (
  TodoListView, 
  TodoCreateView, 
  TodoUpdateView, 
  TodoDeleteView, 
  TodoCompleteView,
)

urlpatterns = [
  path("", TodoListView.as_view(), name="todo_list"),
  path('login/', auth_views.LoginView.as_view(template_name='registration/login.html'), name='login'),
  path('logout/', auth_views.LogoutView.as_view(template_name='todos/templates/registration/logged_out.html'), name='logout'),
  path("create/", TodoCreateView.as_view(), name="todo_create"),
  path("update/<int:pk>", TodoUpdateView.as_view(), name="todo_update"),
  path("delete/<int:pk>", TodoDeleteView.as_view(), name="todo_delete"),
  path("complete/<int:pk>", TodoCompleteView.as_view(), name="todo_complete"),

]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
