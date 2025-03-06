
from django import forms
from django.contrib.auth.mixins import LoginRequiredMixin

from items.models import Items, ItemTombo


class ItemsForm(LoginRequiredMixin, forms.ModelForm):
   
   CATEGORY_CHOICES = [
      ('', 'SELECIONAR'),
      ('MATERIAL PARA INSTALAÇÃO', 'MATERIAL PARA INSTALAÇÃO'),
      ('INFORMÁTICA', 'INFORMÁTICA'),
      ('FERRAMENTA', 'FERRAMENTA'),
      ('MATERIAL DE CONSUMO', 'MATERIAL PARA CONSUMO'),
      ('IMOVEIS', 'IMOVEIS'),
      ('DESCARTE', 'DESCARTE')
   ]

   SUB_CATEGORY_CHOICES = [
      ('', 'SELECIONAR'),  # Valor padrão vazio
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
      choices = [('', 'SELECIONAR')],
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
     
   def clean_quantity(self):

      valor = self.cleaned_data.get('quantity')

      if valor < 1:
         raise forms.ValidationError('O valor deve ser maior ou igual a 1.')
      return valor

   def __init__(self, *args, **kwargs):
      
      super(ItemsForm, self).__init__(*args, **kwargs)
      
      self.fields['category'].choices = self.CATEGORY_CHOICES
      self.fields['sub_category'].choices = self.SUB_CATEGORY_CHOICES
      
      if 'category' in self.data:
         
         category = self.data.get('category')
         self.fields['sub_category'].choices = [
            (sub_cat, sub_cat) for sub_cat in self.get_subcategories(category)
         ]
         
      elif self.instance.pk:
         
         self.fields['category'].initial = self.instance.category
         self.fields['sub_category'].initial = self.instance.sub_category
         
         # Aqui você pode definir como quer salvar os tombos associados no campo de tombo 
         tombos = ItemTombo.objects.filter(item = self.instance)
         tombo_str = "\n ".join([t.tombo for t in tombos])  # Junta todos os tombos com quebra de linhas 
         self.fields['tombo'].initial = tombo_str
                
      
   def get_subcategories(self, category): 
      
      subcategories = {
      'SELECIONAR': [],
      'MATERIAL PARA INSTALAÇÃO' : ['ELÉTRICAS', 'REDE', 'OUTROS'],
      'INFORMÁTICA': ['EQUIPAMENTOS', 'SUPRIMENTOS', 'ACESSÓRIOS', 'PERIFÉRICOS', 'PEÇAS DE REPOSIÇÃO', 'OUTROS'],
      'FERRAMENTA': ['NÃO HÁ SUB CATEGORIAS'],
      'IMOVEIS': ['NÃO HÁ SUB CATEGORIAS'],
      'MATERIAL DE CONSUMO' : ['ITEM USADO'],
      'DESCARTE' : ['NÃO HÁ SUB CATEGORIAS']
      }
       
      return subcategories.get(category, [])

class ItemsFormRetirarStock(LoginRequiredMixin, forms.ModelForm):

   quantity = forms.IntegerField(min_value=1)
   location = forms.CharField(max_length=100)

   class Meta:
      model = Items
      fields = ['quantity', 'location']

   def clean_quantity(self):
      quantity_to_item = self.cleaned_data.get('quantity')
      item = self.instance

      # Verifica se a quantidade a ser retirada é maior ou igual à quantidade disponível
      if quantity_to_item > item.quantity:
         raise forms.ValidationError("A quantidade a retirar não pode ser maior que à quantidade disponível em estoque.")
         
      return quantity_to_item

   def __init__(self, *args, **kwargs):
      
      super(ItemsFormRetirarStock, self).__init__(*args, **kwargs)
      
      # Definiremos que o valor da localização seja limpo do valor anterior 
      if self.instance and self.instance.pk:
         self.initial['location'] = ''
         self.fields['location'].widget.attrs['value'] = ''