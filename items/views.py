from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View

from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from django import forms
from django.views.generic import TemplateView

from django.urls import reverse_lazy
from .models import Items
    
class ItemsListView(LoginRequiredMixin, ListView):
   model = Items
   template_name = 'items/items_main.html'

class ItemsStockView(LoginRequiredMixin, TemplateView):
   model = Items
   template_name = 'items/items_stock.html'

class ItemsForm(LoginRequiredMixin, forms.ModelForm):
    
   class Meta:
      model = Items
      fields = ["quantity", "title", "category"]

   def __init__(self, *args, **kwargs):
      super(ItemsForm, self).__init__(*args, **kwargs)
      self.fields['category'].widget = forms.Select(choices=[
         ('Eletrônico', 'Eletrônico'),
         ('Material Eletrico', 'Material Elétrico'),
         ('Componentes', 'Componente'),
      ])
      self.fields['category'].widget.attrs.update({'class': 'form-select custom-select'})

class ItemsCreateView(LoginRequiredMixin, CreateView):
   model = Items
   form_class = ItemsForm
   success_url = reverse_lazy("items_main")

class ItemsUpdateView(UpdateView):
   model = Items
   fields = ["title", "category", "quantity"]
   success_url = reverse_lazy("items_main")

class ItemsDeleteView(LoginRequiredMixin, DeleteView):
   model = Items
   success_url = reverse_lazy("items_main")   

class ItemsCompleteView(LoginRequiredMixin, View):
   def get(self, request, pk):
      Items = get_object_or_404(Items, pk=pk)
      Items.mark_has_complete()
      return redirect("items_main")

   