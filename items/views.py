from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render

from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View
from django.views.generic.edit import FormView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy

from items.forms.forms import ItemsFormCreate, ItemsFormRetirarStock
from .models import Items, ItemsAuditLog

class ItemsListView(LoginRequiredMixin, ListView):
   model = Items
   template_name = 'items/items_main.html'
   context_object_name = 'items_list'

   def post(self, request, *args, **kwargs):
      # Verificar qual botão foi pressionado
      action = request.POST.get('action')

   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      
      # Obtém a lista de itens
      items = context['items_list']
      
      # Verifica se há itens em cada categoria e adiciona ao contexto
      context['has_material_intalacao'] = any(item.category == "MATERIAL PARA INSTALAÇÃO" for item in items)
      context['has_informatica'] = any(item.category == "INFORMÁTICA" for item in items)
      context['has_material_consumo'] = any(item.category == "MATERIAL DE CONSUMO" for item in items)
      context['has_descarte'] = any(item.category == "DESCARTE" for item in items)
      context['has_ferramenta'] = any(item.category == "FERRAMENTA" for item in items)
      
      # Adiciona lista de categorias únicas
      context['categories'] = Items.objects.values_list('category', flat=True).distinct()

      return context

class ItemsSubMaterialInstalacao(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_material_instalacao.html"
   context_object_name = 'item_material_aplicacao_list'

   def get_queryset(self):
        category = self.kwargs['category']
        return Items.objects.filter(category=category)
   
   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      items = context['item_material_aplicacao_list']

      context['has_eletricas'] = any(item.sub_category == "ELÉTRICAS" for item in items)
      context['has_rede'] = any(item.sub_category == "REDE" for item in items)
      context['has_outros'] = any(item.sub_category == "OUTROS" for item in items)

      return context

class ItemsSubDescarte(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_descarte.html"
   context_object_name = 'item_descarte_list'

   def get_queryset(self):
        category = self.kwargs['category']
        return Items.objects.filter(category=category)

class ItemsSubMaterialConsumo(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_material_consumo.html"
   context_object_name = 'item_material_consumo_list'

   def get_queryset(self):
        category = self.kwargs['category']
        return Items.objects.filter(category=category)
   
   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      items = context['item_material_consumo_list']

      return context
   
class ItemsSubInformatica(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_informatica.html"
   context_object_name = 'item_informatica_list'

   def get_queryset(self):
        category = self.kwargs['category']
        return Items.objects.filter(category=category)
   
   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      items = context['item_informatica_list']

      context['has_equipamentos'] = any(item.sub_category == "EQUIPAMENTOS" for item in items)
      context['has_suprimentos'] = any(item.sub_category == "SUPRIMENTOS" for item in items)
      context['has_acessorios'] = any(item.sub_category == "ACESSÓRIOS" for item in items)
      context['has_perifericos'] = any(item.sub_category == "Periféricos" for item in items)
      context['has_pecas_reposicao'] = any(item.sub_category == "Peças de reposição" for item in items)
      context['has_outros'] = any(item.sub_category == "Outros" for item in items)

      return context

class ItemsSubFerramentas(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_ferramentas.html"
   context_object_name = 'item_ferramenta_list'

   def get_queryset(self):
        category = self.kwargs['category']
        return Items.objects.filter(category=category)

class ItemsCreateView(LoginRequiredMixin, CreateView):
   model = Items
   form_class = ItemsFormCreate
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

# atualiza a quantidade de unidades após retirada de produtos no estoque
class ItemsRetirarStock(LoginRequiredMixin, FormView, DeleteView):

   template_name = 'items/items_form_retirar.html'
   form_class = ItemsFormRetirarStock

   def get_object(self):
      item_id = self.kwargs.get('pk')
      return get_object_or_404(Items, id=item_id)

   def get_form_kwargs(self):
      kwargs = super().get_form_kwargs()
      kwargs['instance'] = self.get_object()
      return kwargs

   def form_valid(self, form):
      item = self.get_object()
      quantity_to_item = form.cleaned_data['quantity']
      
      if quantity_to_item > item.quantity:
         return self.form_invalid(form)
      else:
         item.quantity -= quantity_to_item
         item.save()
         return redirect('items_main')

   def form_invalid(self, form):
      return self.render_to_response(self.get_context_data(form=form))

class ItemsAuditLogView(LoginRequiredMixin, View):
    template_name = 'items/itemsAuditLog.html'

    def get(self, request, *args, **kwargs):
        logs = ItemsAuditLog.objects.all().order_by('-timestamp')
        context = {'logs': logs}
        return render(request, self.template_name, context)

@method_decorator(login_required, name='dispatch')
class SomeView(LoginRequiredMixin, View):
    def post(self, request, *args, **kwargs):
        item = get_object_or_404(Items, pk=kwargs['pk'])  # Garante que o item existe
        item.modified_by = request.user  # Define o usuário que está modificando o item
        item.save()
        return redirect('itemsAuditLog')  # Redireciona para a página de logs

