
from django import forms
from django.contrib.auth.mixins import LoginRequiredMixin
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit, Row, Column
from django.forms import inlineformset_factory

from items.models import Items, ItemTombo


class ItemsFormCreate(LoginRequiredMixin, forms.ModelForm):
    
   # Dicionario usando em campos Select | category e sub-category
   CATEGORY_CHOICES = [
      ('', 'Selecionar'),
      ('Material para instalação', 'Material para instalação'),
      ('Informática', 'Informática'),
      ('Ferramenta', 'Ferramenta'),
      ('Material de Consumo', 'Material de Consumo'),
      ('Descarte', 'Descarte')   
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

   tombo = forms.CharField(
      label='Tombo',
      required=False,
      widget=forms.TextInput(
         attrs={
            'class': 'form-control',
            'placeholder': 'Digite o tombo do item..'
         },
      ),
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
      fields = ["name", "tombo", "brand", "model", "location", "category", "sub_category", "quantity", "observation"]

   def __init__(self, *args, **kwargs):

      super(ItemsFormCreate, self).__init__(*args, **kwargs)

      # Atualiza subcategorias com base na categoria selecionada
      if 'category' in self.data :

         category = self.data.get ( 'category' ) 
         self.fields [ 'sub_category' ].choices = [
            (sub_cat, sub_cat)  for sub_cat in self.get_subcategories(category)
         ]

      elif self.instance.pk:

         category = self.instance.category
         self.fields[ 'sub_category' ].choices = [
            (sub_cat, sub_cat) for sub_cat in self.get_subcategories(category)
         ]

   def get_subcategories(self, category):

      subcategories = {
         'Selecionar': [],
         'Material para instalação': ['Elétricas', 'Rede', 'Outros'],
         'Informática': ['Equipamentos', 'Suprimentos', 'Acessórios', 'Periféricos', 'Peças de reposição', 'Outros'],
         'Ferramenta': ['Não sub categorias'],
         'Material de Consumo': ['Item usado'],
         'Descarte': ['Não a sub categorias']
      }

      return subcategories.get(category, [])

   def clean_quantity(self):

      valor = self.cleaned_data.get('quantity')

      if valor < 1:
         raise forms.ValidationError('O valor deve ser maior ou igual a 1.')
      return valor

   def save(self, commit=True):

      item = super(ItemsFormCreate, self).save(commit=False)

      if commit:
         item.save()
      
      return item

class ItemTomboForm(forms.ModelForm):
   
   tombo = forms.CharField (
      label = 'Tombo',
      required = False, 
      widget = forms.TextInput (
         attrs = {
            'class': 'form-control',
            'placeholder': 'Digite o tombo do item..'
         },
      ),
   )

   class Meta:

      model = ItemTombo
      fields = ['tombo']

   def __init__(self, *args, **kwargs):

      self.helper = FormHelper()
      self.helper.form_class = 'form-horizontal'
      self.helper.layout = Layout(
         Row (
            
            Column (
               'tombo',
               css_class = 'form-group col-md-8 mb-0'
            ),

            Column (
               Submit (
                  'submit_button',
                  '+',
                  css_class = 'btn btn-primary'
               ),
               css_class='form-group col-md-4 mb-0'
            ),
            css_class='form-row'

         ),

      )

# FormsSet para múltiplos tombos
ItemTomboFormSet = inlineformset_factory(
   Items,
   ItemTombo, 
   fields = ('tombo',),
   form = ItemTomboForm, 
   extra = 1 ,
   can_delete = True,
)

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