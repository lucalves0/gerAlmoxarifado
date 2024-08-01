
from django import forms
from django.contrib.auth.mixins import LoginRequiredMixin

from items.models import Items

class ItemsForm(LoginRequiredMixin, forms.ModelForm):
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
        
   def __init__(self, *args, **kwargs):
      super(ItemsForm, self).__init__(*args, **kwargs)
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