from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, View
from django.views.generic.edit import FormView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy
from django.http import HttpResponse
from django.db.models import Count, Q

from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet

from io import BytesIO
from datetime import datetime
import json

from .forms.forms import ItemsForm, ItemsFormRetirarStock
from .models import Items, ItemsAuditLog, ItemTombo

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

class ItemsCreateView(LoginRequiredMixin, CreateView):

   model = Items
   form_class = ItemsForm
   success_url = reverse_lazy("items_main")
   template_name = "items/items_form.html"
   
   def get_context_data(self, **kwargs):
      
      context = super().get_context_data(**kwargs)
      context['title'] = "Ficha de cadastro técnico de itens"
      context['previous_page'] = self.request.META.get('HTTP_REFERER')
      return context
   
   def form_valid(self, form):
      

      self.object = form.save(commit = False)
      self.object.created_by = self.request.user
      self.object.save()
      
      tombo_str = form.cleaned_data.get('tombo')
      
      if tombo_str:
         
         tombos = [t.strip() for t in tombo_str.splitlines() if t.strip()]
         for tombo in tombos: 
            ItemTombo.objects.create(item = self.object, tombo = tombo)
      
      return redirect(self.get_success_url())
   
   def form_invalid(self, form):
      return super().form_invalid(form)  # Retorna a resposta padrão de formulário inválido
   
class ItemsUpdateView(LoginRequiredMixin, UpdateView):
   
   model = Items
   form_class = ItemsForm
   success_url = reverse_lazy("items_main")
   template_name = "items/items_form.html"
   
   def get_queryset(self):
      
      # Aqui garantimos que o queryset está buscando pelo UUID corretamente 
      return Items.objects.filter(id=self.kwargs['pk'])
   
   def get_context_data(self, **kwargs):
      
      context = super().get_context_data(**kwargs)
      
      # Pegar o valor inicial de category e sub_category do item atual
      item = self.get_object()
      context['initial_category'] = item.category  # Passa o valor da categoria para o contexto
      context['initial_sub_category'] = item.sub_category  # Passa o valor da subcategoria para o contexto
      context['is_view_mode'] = False  # Indica que estamos em modo de visualização
      context['title'] = "Ficha de atualização de informações"
      context['previous_page'] = self.request.META.get('HTTP_REFERER')
      
      return context
     
   def form_valid(self, form):
      
      self.object = form.save(commit=False)        # Não salva imediatamente 
      self.object.modified_by = self.request.user  # Atualiza o campo 'modified_by'
      self.object.save()                           # Salva a instância do item
      
      # Captura o valor do campo 'tombo'
      tombo_str = form.cleaned_data.get('tombo')
      
      # Verifica se tombo não está vazio 
      if tombo_str:
         
         # Remove tombos existentes para associar o novo 
         ItemTombo.objects.filter(item = self.object).delete()
         
         # Quebra os tombos por linha e salva como tombos separados
         tombos = [t.strip() for t in tombo_str.splitlines() if t.strip()]
         for tombo in tombos: 
            ItemTombo.objects.create(item = self.object, tombo = tombo)

      return redirect(self.get_success_url())
      
class ItemsDeleteView(LoginRequiredMixin, DeleteView):
   model = Items
   success_url = reverse_lazy("items_main") 

   def get_object(self):
      id = self.kwargs.get('pk')
      return get_object_or_404(Items, id=id) 
   
   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      context['previous_page'] = self.request.META.get('HTTP_REFERER')  # Armazena a URL anterior
      return context

class ItemsFichaTecnica(LoginRequiredMixin, UpdateView):
   
    model = Items
    form_class = ItemsForm
    success_url = reverse_lazy("items_main")

    def get_object(self):
       
      id = self.kwargs.get('pk')
      return get_object_or_404(Items, id=id)
   
    def get_form(self, form_class=None):
       
      form = super().get_form(form_class)
      
      # Define todos os campos como somente leitura
      for field in form.fields.values():
         field.widget.attrs['readonly'] = True
      
      # Define o campo tombo como somente leitura
      item = self.get_object()
      item_tombo_instance = item.tombos.first()  # Assume que há um ItemTombo associado
      form.fields['tombo'].initial = item_tombo_instance.tombo if item_tombo_instance else ''
      form.fields['tombo'].widget.attrs['readonly'] = True
      
      # Define os campos select category e sub_category como somente leitura (desabilitados)
      form.fields['category'].widget.attrs['disabled'] = True
      form.fields['sub_category'].widget.attrs['disabled'] = True
      
      return form
   
    def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      context['title'] = "Ficha Técnica"
      context['is_view_mode'] = True  # Indica que estamos em modo de visualização
      context['previous_page'] = self.request.META.get('HTTP_REFERER')  # Armazena a URL anterior
      return context

class ItemSearchView(ListView):
   model = Items
   template_name = 'items/items_search.html'
   context_object_name = 'results'
   
   def get_queryset(self):
      
      query = self.request.GET.get('query')
      
      if query:
         return Items.objects.filter (name__icontains = query)
      
      return Items.objects.none() # Retorna uma QuerySet vazia se não houver busca
     
class LoadSubcategoriesView(View):

   def get(self, request):
      
      category = request.GET.get('category')
      
      subcategories = {
      'SELECIONAR': [],
      'MATERIAL PARA INSTALAÇÃO' : ['ELÉTRICAS', 'REDE', 'OUTROS'],
      'INFORMÁTICA': ['EQUIPAMENTOS', 'SUPRIMENTOS', 'ACESSÓRIOS', 'PERIFÉRICOS', 'PEÇAS DE REPOSIÇÃO', 'OUTROS'],
      'FERRAMENTA': ['NÃO SUB HÁ CATEGORIAS'],
      'MATERIAL DE CONSUMO' : ['ITEM USADO'],
      'DESCARTE' : ['NÃO HÁ SUB CATEGORIAS']
      }
       
      subcats = subcategories.get(category, [])
      return JsonResponse(subcats, safe=False)

# atualiza a quantidade de unidades após retirada de produtos no estoque
class ItemsRetirarStock(LoginRequiredMixin, FormView, DeleteView):

   template_name = 'items/items_form_retirar.html'
   form_class = ItemsFormRetirarStock
        
   def get_object(self):
      
      id = self.kwargs.get('id')
      return get_object_or_404(Items, id=id)

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
         
         if form.should_delete:
            item.delete()
         else:
            item.save()
         
         return redirect('items_main')

   def form_invalid(self, form):
      return self.render_to_response(self.get_context_data(form=form))

   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      context['previous_page'] = self.request.META.get('HTTP_REFERER')  # Armazena a URL anterior
      return context

class ItemsAuditLogView(LoginRequiredMixin, View):
   
   model = ItemsAuditLog
   template_name = 'items/itemsAuditLog.html'
   context_object_name = 'results'

   def get(self, request, *args, **kwargs):
      
      # Obtém a query de pesquisa
      action = self.request.GET.get('action')
      item = self.request.GET.get('item')
      
      # Base da consulta
      logs = ItemsAuditLog.objects.all()
      
      # Filtra pela ação do item se fornecido
      if action:
         logs = logs.filter(action__icontains=action)
      
         
      # Filtra pelo nome do item se fornecido
      if item:
         logs = logs.filter(item__name__icontains=item)
      
      logs = logs.order_by('-timestamp')
      
      # Verifica se o parâmetro `download_pdf` foi enviado
      if request.GET.get('download_pdf'):
         
         buffer = BytesIO()  # Cria um buffer para o PDF
         doc = SimpleDocTemplate(buffer, pagesize=A4,
                                 leftMargin=40, rightMargin=40,
                                 topMargin=40, bottomMargin=40)
         
         elements = []
         styles = getSampleStyleSheet()
         title_style = styles['Title']

         # Título com a data e hora
         current_time = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
         title = f"Relatório de Ações - Gerado em: {current_time}"
         elements.append(Paragraph(title, title_style))
         elements.append(Spacer(1, 12))  # Espaçamento após o título

         # Dados da tabela
         data = [['Ação', 'Item', 'Usuário', 'Data/Hora', 'Observação']]  # Cabeçalhos da tabela

         # Adiciona os dados de cada log na tabela
         for log in logs:
            data.append([log.action, log.item_deletado, str(log.user), log.timestamp.strftime("%d/%m/%Y %H:%M:%S"), log.observation])
         
         # Estilo do PDF
         colWidths = [60, 100, 80, 100, 180]  # Larguras em pontos
         table = Table(data, colWidths=colWidths)
         style = TableStyle([
               ('BACKGROUND', (0, 0), (-1, 0), colors.gray),
               ('TEXTCOLOR', (0, 0), (-1, 0), colors.black),
               ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
               ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
               ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
               ('BACKGROUND', (0, 1), (-1, -1), colors.white),
               ('GRID', (0, 0), (-1, -1), 1, colors.black),
         ])

         table.setStyle(style)
         elements.append(table)  # Adiciona a tabela ao documento
         doc.build(elements)     # Constrói o documento PDF
         buffer.seek(0)          # Retorna o PDF como resposta

         return HttpResponse(buffer, content_type='application/pdf')

      # Renderiza a página normalmente se não for pedido o download
      context = {
         'results': logs, 
         'action': action,
         'item' : item,
      }
      
      return render(request, self.template_name, context)
   
   
@method_decorator(login_required, name='dispatch')
class SomeView(LoginRequiredMixin, View):
    def post(self, request, *args, **kwargs):
      item = get_object_or_404(Items, pk=kwargs['pk'])  # Garante que o item existe
      item.save(user=request.user)
      return redirect('itemsAuditLog')  # Redireciona para a página de logs

class ItemsSubMaterialInstalacao(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_material_instalacao.html"
   context_object_name = 'item_material_aplicacao_list'

   def get_queryset(self):
      
      category = self.kwargs['category']
      
      # Usando prefetch_related para carregar os tombos associados 
      return Items.objects.filter(category=category).prefetch_related('tombos')
   
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
      
      # Usando prefetch_related para carregar os tombos associados 
      return Items.objects.filter(category=category).prefetch_related('tombos')

class ItemsSubMaterialConsumo(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_material_consumo.html"
   context_object_name = 'item_material_consumo_list'

   def get_queryset(self):
      
      category = self.kwargs['category']
      
      # Usando prefetch_related para carregar os tombos associados 
      return Items.objects.filter(category=category).prefetch_related('tombos')

class ItemsSubInformatica(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_informatica.html"
   context_object_name = 'item_informatica_list'

   def get_queryset(self):
      category = self.kwargs['category']
      
      # Usando prefetch_related para carregar os tombos associados 
      return Items.objects.filter(category=category).prefetch_related('tombos')
   
   def get_context_data(self, **kwargs):
      context = super().get_context_data(**kwargs)
      items = context['item_informatica_list']

      context['has_equipamentos'] = any(item.sub_category == "EQUIPAMENTOS" for item in items)
      context['has_suprimentos'] = any(item.sub_category == "SUPRIMENTOS" for item in items)
      context['has_acessorios'] = any(item.sub_category == "ACESSÓRIOS" for item in items)
      context['has_perifericos'] = any(item.sub_category == "PERIFÉRICOS" for item in items)
      context['has_pecas_reposicao'] = any(item.sub_category == "PEÇAS DE REPOSIÇÃO" for item in items)
      context['has_outros'] = any(item.sub_category == "OUTROS" for item in items)

      return context

class ItemsSubFerramentas(LoginRequiredMixin, ListView):
   model: Items
   template_name = "items/pag_sub_category/items_ferramentas.html"
   context_object_name = 'item_ferramenta_list'

   def get_queryset(self):
      
      category = self.kwargs['category']
      
      # Usando prefetch_related para carregar os tombos associados 
      return Items.objects.filter(category=category).prefetch_related('tombos')
   
class DashboardView(View):
   
   def get(self, request, *args, **kwargs):
      
      # Coletar dados do banco de dados
      total_items = Items.objects.count()
      items_by_category = Items.objects.values('category').annotate(count=Count('id'))
      recent_items = Items.objects.order_by('-create_at')[:5]  # Exemplo: últimos 5 itens cadastrados

      context = {
         'total_items': total_items,
         'items_by_category': json.dumps(items_by_category),
         'recent_items': recent_items,
      }

      return render(request, 'items/itemsDashboard.html', context)