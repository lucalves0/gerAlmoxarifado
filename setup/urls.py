from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

from todos.views import (
  TodoListView, 
  TodoCreateView, 
  TodoUpdateView, 
  TodoDeleteView, 
  TodoCompleteView,
  LoginView
)

urlpatterns = [
  path("admin/", admin.site.urls),
  path("", TodoListView.as_view(), name="todo_list"),
  path("create/", TodoCreateView.as_view(), name="todo_create"),
  path("update/<int:pk>", TodoUpdateView.as_view(), name="todo_update"),
  path("delete/<int:pk>", TodoDeleteView.as_view(), name="todo_delete"),
  path("complete/<int:pk>", TodoCompleteView.as_view(), name="todo_complete"),
  path("login/", LoginView.as_view(), name="login"),
  path('todos/', include('todos.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
