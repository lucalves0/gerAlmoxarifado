
from django import forms
from django.contrib.auth.mixins import LoginRequiredMixin

from items.models import Items

class ItemsFormCreate(LoginRequiredMixin, forms.ModelForm):
   CATEGORY_CHOICES = [
      ('', 'Selecionar'),
      ('Material para instalação', 'Material para instalação'),
      ('Informática', 'Informática'),
      ('Ferramenta', 'Ferramenta'),
      ('Material de Consumo', 'Material de Consumo', ),
      ('Descarte', 'Descarte')
   ]
   
   SUB_CATEGORY_CHOICES = [
      ('', 'Selecione'),  # Valor padrão vazio
   ] 

   category = forms.ChoiceField(choices=CATEGORY_CHOICES, widget=forms.Select(attrs={'class': 'form-control'}), label="Categoria")
   sub_category = forms.ChoiceField(choices=SUB_CATEGORY_CHOICES, widget=forms.Select(attrs={'class': 'form-control'}), label="Sub-Categoria")

   class Meta:
      model = Items
      fields = ["name", "brand", "model", "location", "category", "sub_category", "quantity", "observation"]
      
      widgets = {
         'category': forms.Select(attrs={'class': 'form-control'}),
         'sub_category': forms.Select(attrs={'class': 'form-control'}),
      }

      def clean_quantity(self):
         quantity_to_item = self.cleaned_data.get('quantity')
         item = self.instance

         # Verifica se a quantidade a ser retirada é maior ou igual à quantidade disponível
         if quantity_to_item <= 0:
            raise forms.ValidationError("Insira o valor acima de 0 ")
         
         return quantity_to_item
        
   def __init__(self, *args, **kwargs):
      super(ItemsFormCreate, self).__init__(*args, **kwargs)
      self.fields['category'].choices = self.CATEGORY_CHOICES
      self.fields['sub_category'].choices = self.SUB_CATEGORY_CHOICES
      
      if 'category' in self.data:
            category = self.data.get('category')
            self.fields['sub_category'].choices = [(sub_cat, sub_cat) for sub_cat in self.get_subcategories(category)]
      elif self.instance.pk:
         category = self.instance.category
         self.fields['sub_category'].choices = [(sub_cat, sub_cat) for sub_cat in self.get_subcategories(category)]
   
   def get_subcategories(self, category):
      subcategories = {
         'Selecionar': [],
         'Material para instalação': ['Elétricas', 'Rede', 'Outros'],
         'Informática': ['Equipamentos', 'Suprimentos', 'Acessórios', 'Periféricos', 'Peças de reposição', 'Outros'],
         'Ferramenta': ['Não sub categorias'],
         'Material de Consumo' : ['Item usado'],
         'Descarte' : ['Não a sub categorias']
      }
      return subcategories.get(category, [])

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