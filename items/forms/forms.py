
from django import forms
from django.contrib.auth.mixins import LoginRequiredMixin

from items.models import Items, ItemTombo


class ItemsFormCreate(LoginRequiredMixin, forms.ModelForm):
    
   # Dicionario usando em campos Select | category e sub-category
   CATEGORY_CHOICES = [
      ('', 'Selecionar'),
      ('MATERIAL PARA INSTALAÇÃO', 'MATERIAL PARA INSTALAÇÃO'),
      ('INFORMÁTICA', 'INFORMÁTICA'),
      ('FERRAMENTE', 'FERRAMENTE'),
      ('MATERIAL DE CONSUMO', 'MATERIAL DE CONSUMO'),
      ('DESCARTE', 'DESCARTE')   
   ]

   SUB_CATEGORY_CHOICES = [
      ('', 'Selecione'),
   ]

   name = forms.CharField (
      label = "Nome",
      widget = forms.TextInput (
         attrs = {
            'class' : 'form-control',
            'placeholder': 'Digite o nome do item..'
            
         }
      )
   )

   brand = forms.CharField (
      label = "Marca",
      widget = forms.TextInput (
         attrs = {
            'class' : 'form-control',
            'placeholder': 'Digite a marca do item..'
            
         }
      )
   )

   model = forms.CharField (
      label = "Modelo",
      widget = forms.TextInput (
         attrs = {
            'class' : 'form-control',
            'placeholder': 'Digite o modelo do item..'
            
         }
      )
   )

   location = forms.CharField (
      label = "Localização",
      widget = forms.TextInput (
         attrs = {
            'class' : 'form-control',
            'placeholder': 'Digite o local está armazenado o item..'
            
         }
      )
   )

   category = forms.ChoiceField (
      choices = CATEGORY_CHOICES,
      label = "Categoria",
      widget = forms.Select (
         attrs = {
            'class': 'form-control',
         }
      )  
   )

   sub_category = forms.ChoiceField (
      choices = SUB_CATEGORY_CHOICES,
      label="Sub-Categoria",
      widget = forms.Select (
         attrs = {
            'class': 'form-control',
         }
      ) 
   )

   quantity = forms.IntegerField (
      label = 'Quantidade',
      min_value = 1,
      error_messages = {
         'min_value': 'O valor deve ser maior ou igual a 1.'
      },
      widget = forms.NumberInput ( 
         attrs = {
            'class': 'form-control',  
            'placeholder': 'Digite quantas unidades possi do item..'
         }
      )
   )
   
   tombo = forms.CharField (
      label = 'Tombo',
      required = False, 
      widget = forms.Textarea (
         attrs = {
            'class': 'form-control',
            'placeholder': 'Especifique os tombos dos itens associados a este cadastro',
            'row' : 3,
            'style' : 'resize: vertical;'
         },
      ),
   )

   observation = forms.CharField (
      label="Observação",
      required = False,
      widget = forms.Textarea (
         attrs = {
            'class' : 'form-control',
            'placeholder': 'Digite sua observação se necessário',
            'row' : 10,                   # tamanho inicial      
            'style': 'resize: vertical;'  # permite crescer verticamente
         }
      )
   )
   
   class Meta:
      model = Items
      fields = ["name","brand", "model", "location", "category", "sub_category", "quantity", "tombo", "observation"]

   def __init__(self, *args, **kwargs):

      super(ItemsFormCreate, self).__init__(*args, **kwargs)
      
      # Se o item já existe (no modo atualização), busque o campos os valores associados aos campos
      if self.instance.pk:

         # Carrega a categoria e sub - categorias salvas
         category = self.instance.category
         sub_category = self.instance.sub_category
         
         # Define os valores iniciais de category e sub_category com os valores salvos
         self.fields['category'].initial = category
         self.fields['sub_category'].choices = [
            (sub_cat, sub_cat) for sub_cat in self.get_subcategories(category)
         ]
         self.fields['sub_category'].initial = sub_category
                
         # Aqui você pode definir como quer salvar os tombos associados no campo de tombo 
         tombos = ItemTombo.objects.filter(item = self.instance)
         tombo_str = "\n ".join([t.tombo for t in tombos])  # Junta todos os tombos com quebra de linhas 
         self.fields['tombo'].initial = tombo_str

      # Atualiza subcategorias com base na categoria selecionada
      elif 'category' in self.data :

         category = self.data.get('category') 
         self.fields ['sub_category'].choices = [
            (sub_cat, sub_cat)  for sub_cat in self.get_subcategories(category)
         ]
         
      else:
         
         # No modo de criação, ou se não houver dados de categoria; exibe a opção por padrão
         self.fields['sub_category'].choices = self.SUB_CATEGORY_CHOICES

   def get_subcategories(self, category):

      subcategories = {
         'Selecionar': [],
         'MATERIAL PARA INSTALAÇÃO': ['ELÉTRICAS', 'REDE', 'OUTROS'],
         'INFORMÁTICA': ['EQUIPAMENTOS', 'SUPRIMENTOS', 'ACESSÓRIOS', 'PERIFÉRICOS', 'PEÇAS DE REPOSIÇÃO', 'OUTROS'],
         'FERRAMENTA': ['NÃO SUB CATEGORIAS'],
         'MATERIAL DE CONSUMO': ['ITEM USADO'],
         'DESCARTE': ['NÃO A SUB CATEGORIAS']
      }

      return subcategories.get(category, [])

   def clean_quantity(self):

      valor = self.cleaned_data.get('quantity')

      if valor < 1:
         raise forms.ValidationError('O valor deve ser maior ou igual a 1.')
      return valor

class ItemsFormRetirarStock(LoginRequiredMixin, forms.ModelForm):

   quantity = forms.IntegerField(min_value=1, label="Quantidade a retirar")

   class Meta:
      model = Items
      fields = ['quantity']

   def clean_quantity(self):
      quantity_to_item = self.cleaned_data.get('quantity')
      item = self.instance

      # Verifica se a quantidade a ser retirada é maior ou igual à quantidade disponível
      if quantity_to_item > item.quantity:
         raise forms.ValidationError("A quantidade a retirar não pode ser maior que à quantidade disponível em estoque.")
         
      # Define a flag para deletar o item se a quantidade for igual
      if quantity_to_item == item.quantity:
         self.should_delete = True

      return quantity_to_item