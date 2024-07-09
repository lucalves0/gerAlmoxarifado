from sre_parse import CATEGORIES
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView

from django.urls import reverse, reverse_lazy

from items.forms.forms import ItemsForm, ItemsRetirarForm
from .models import Items
    
class ItemsListView(LoginRequiredMixin, ListView):
   model = Items
   template_name = 'items/items_main.html'

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

class ItemsRetirarView(View):
    template_name = 'retirar_produto.html'
    form_class = ItemsRetirarForm

    def get(self, request, pk):
        items = get_object_or_404(Items, pk=pk)
        form = self.form_class(initial={'items_id': items.pk})
        return render(request, 'retirar_produto.html', {'form': form, 'items': items})

    def post(self, request, pk):
        form = self.form_class(request.POST)
        if form.is_valid():
            items_quantity_retirar = form.cleaned_data['quantity']
            items = get_object_or_404(Items, pk=pk)
 
            if items.quantity >= items_quantity_retirar:
               items.quantity  -= items_quantity_retirar
               items.save()
               return redirect(reverse('items_stock_success'))
            else:
               form.add_error(None, 'Quantidade em estoque insuficiente.')

        return render(request, 'retirar_produto.html', {'form': form, 'items': items})

class EstoqueSucessoView(View):
    template_name = 'items_stock_success.html'

    def get(self, request):
        return render(request, self.template_name)
   