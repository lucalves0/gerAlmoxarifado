from datetime import date
from django.db import models

class Items(models.Model):
    name = models.CharField(verbose_name="Nome", max_length=100, null=False, blank=False, default='')
    brand = models.CharField(verbose_name="Marca", max_length=100, default='')
    model = models.CharField(verbose_name="Modelo", max_length=100, blank=False, default='')
    location = models.CharField(verbose_name="Localização", max_length=100, null=False, blank=False, default='')
    category = models.CharField(verbose_name="Categoria", max_length=100, default='')
    sub_category = models.CharField(verbose_name="Sub-Categoria", max_length=100, default='')
    quantity = models.PositiveIntegerField(verbose_name="Quantidades de Unidades", null=False, blank=False, default=0)
    create_at = models.DateField(auto_now_add=True, null=False, blank=False)
    finished_at = models.DateField(null=True)
    locality = models.CharField(verbose_name="Localidade", max_length=100, blank=False, default='')
    observation = models.CharField(verbose_name="Observação", max_length=300, default='', blank=True)

    def __str__(self):
        return self.name
    
    def mark_has_complete(self):
        if not self.finished_at:
            self.finished_at = date.today()
            self.save()
