from datetime import date
from django.db import models

class Items(models.Model):
    title = models.CharField(verbose_name="Titulo", max_length=100, null=False, blank=False)
    create_at = models.DateField(auto_now_add=True, null=False, blank=False)
    finished_at = models.DateField(null=True)
    category = models.CharField(verbose_name="Categoria", max_length=100, default='Opção Padrão')
    quantity = models.IntegerField(verbose_name="Quantidades de Unidades", null=False, blank=False, default=0)

    def mark_has_complete(self):
        if not self.finished_at:
            self.finished_at = date.today()
            self.save()
