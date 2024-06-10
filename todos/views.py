from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View

from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect, render
from django.utils.decorators import method_decorator

from django.urls import reverse_lazy
from .models import Todo

class LoginRequiredMixin:
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

class TodoListView(LoginRequiredMixin, ListView):
   model = Todo

class TodoCreateView(LoginRequiredMixin, CreateView):
   model = Todo
   fields = ["title", "deadline"]
   success_url = reverse_lazy("todo_list")

class TodoUpdateView(LoginRequiredMixin, UpdateView):
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
   
class LoginView(View):
    template_name = 'todos/login.html'

    def get(self, request):
        return render(request, self.template_name)

    def post(self, request):
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('todo_list')
        else:
            return render(request, self.template_name, {'error': 'Nome de usuário ou senha inválidos'})
   