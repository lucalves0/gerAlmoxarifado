from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View

from django.contrib.auth import authenticate, login
from django.shortcuts import get_object_or_404, redirect, render
from django.contrib import messages
from crispy_forms.helper import FormHelper
from django import forms
from crispy_forms.layout import Layout, Submit, Div

from django.urls import reverse_lazy
from .models import Todo

class TodoListView(ListView):
   model = Todo

class TodoForm(forms.ModelForm):
    
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

class TodoCreateView(CreateView):
   model = Todo
   form_class = TodoForm
   success_url = reverse_lazy("todo_list")

class TodoUpdateView(UpdateView):
   model = Todo
   fields = ["title", "deadline"]
   success_url = reverse_lazy("todo_list")

class TodoDeleteView(DeleteView):
   model = Todo
   success_url = reverse_lazy("todo_list")

class TodoCompleteView(View):
   def get(self, request, pk):
      todo = get_object_or_404(Todo, pk=pk)
      todo.mark_has_complete()
      return redirect("todo_list")
   
class LoginView(View):
    def get(self, request):
        return render(request, 'todos/login.html')

    def post(self, request):
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('todo_list') 
        else:
            messages.error(request, 'Usuário ou senha incorretos')
            return render(request, 'todos/templates/todos/login.html')

   