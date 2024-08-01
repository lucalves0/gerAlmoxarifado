from pyexpat.errors import messages
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView

from django.urls import reverse_lazy

from items.forms.forms import ItemsForm
from .models import Items

class ItemsListView(LoginRequiredMixin, ListView):
   model = Items
   template_name = 'items/items_main.html'
   context_object_name = 'items_list'

   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      
      # Obtém a lista de itens
      items = context['items_list']
      
      # Verifica se há itens em cada categoria e adiciona ao contexto
      context['has_material_intalacao'] = any(item.category == "Material para instalação" for item in items)
      context['has_informatica'] = any(item.category == "Informática" for item in items)
      context['has_ferramentas'] = any(item.category == "Ferramentas" for item in items)
      context['has_material_consumo'] = any(item.category == "Material de consumo" for item in items)
      context['has_descarte'] = any(item.category == "Descarte" for item in items)

      return context

class ItemsStockView(LoginRequiredMixin, TemplateView):
   model = Items
   template_name = 'items/items_stock.html'

class ItemsCreateView(LoginRequiredMixin, CreateView):
   model = Items
   form_class = ItemsForm
   success_url = reverse_lazy("items_main")
    
class LoadSubcategoriesView(View):

    def get(self, request, *args, **kwargs):
        category = request.GET.get('category')
        subcategories = {
            'Selecionar': [],
            'Material para instalação': ['Elétricas', 'Rede', 'Outros'],
            'Informática': ['Equipamentos', 'Suprimentos', 'Acessórios', 'Periféricos', 'Peças de reposição', 'Outros'],
            'Ferramenta': ['Não sub categorias'],
            'Material de Consumo' : ['Item usado'],
            'Descarte' : ['Não a sub categorias']
        }
        subcats = subcategories.get(category, [])
        return JsonResponse(subcats, safe=False)
    
class ItemsUpdateView(UpdateView):
   model = Items
   fields = ["name", "brand", "model", "location", "category", "sub_category", "quantity", "observation"]
   success_url = reverse_lazy("items_main")

class ItemsDeleteView(LoginRequiredMixin, DeleteView):
   model = Items
   success_url = reverse_lazy("items_main")  