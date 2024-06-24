from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View

from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django import forms

from django.urls import reverse_lazy
from .models import Todo

class TodoListView(LoginRequiredMixin, ListView):
   model = Todo
   template_name = 'todo_list.html'
   context_object_name = 'todos'

class TodoForm(LoginRequiredMixin, forms.ModelForm):
    
   class Meta:
      model = Todo
      fields = ["quantity", "title", "category"]

   def __init__(self, *args, **kwargs):
      super(TodoForm, self).__init__(*args, **kwargs)
      self.fields['category'].widget = forms.Select(choices=[
         ('Eletrônico', 'Eletrônico'),
         ('Material Eletrico', 'Material Elétrico'),
         ('Componentes', 'Componente'),
      ])
      self.fields['category'].widget.attrs.update({'class': 'form-select custom-select'})

class TodoCreateView(LoginRequiredMixin, CreateView):
   model = Todo
   form_class = TodoForm
   success_url = reverse_lazy("todo_list")

class TodoUpdateView(UpdateView):
   model = Todo
   fields = ["title", "deadline"]
   success_url = reverse_lazy("todo_list")

class TodoDeleteView(LoginRequiredMixin, DeleteView):
   model = Todo
   success_url = reverse_lazy("todo_list")

class TodoCompleteView(LoginRequiredMixin, View):
   def get(self, request, pk):
      todo = get_object_or_404(Todo, pk=pk)
      todo.mark_has_complete()
      return redirect("todo_list")

   