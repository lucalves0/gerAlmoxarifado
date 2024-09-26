import datetime
import json
import uuid
from django.db import models
from django.conf import settings
from django.forms import ValidationError
from django.utils import timezone
from django.core.serializers.json import DjangoJSONEncoder

User = settings.AUTH_USER_MODEL  # Importar User do settings para evitar ciclos

class Items(models.Model):
    id = models.CharField(primary_key=True, max_length=36, default=uuid.uuid4, editable=False)
    name = models.CharField(verbose_name="Nome", max_length=100, null=False, blank=False, default='')
    brand = models.CharField(verbose_name="Marca", max_length=100, default='')
    model = models.CharField(verbose_name="Modelo", max_length=100, blank=False, default='')
    location = models.CharField(verbose_name="Localização", max_length=100, null=False, blank=False, default='')
    category = models.CharField(verbose_name="Categoria", max_length=100, default='')
    sub_category = models.CharField(verbose_name="Sub-Categoria", max_length=100, default='')
    quantity = models.PositiveIntegerField(verbose_name="Quantidades de Unidades")
    create_at = models.DateField(auto_now_add=True, null=False, blank=False)
    observation = models.CharField(verbose_name="Observação", max_length=600, default='', blank=True)
    modified_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return self.name

    def mark_has_complete(self):
        if not self.finished_at:
            self.finished_at = timezone.now().date()
            self.save()

    def clean(self):
        if self.quantity < 0:
            raise ValidationError("A quantidade não pode ser menor.")
    
    def save(self, *args, **kwargs):
        user = kwargs.pop('user', None)  # Captura o usuário do kwargs
        
        if user:
            if self.pk:                     # Se o item já existe, é uma edição
                self.modified_by = user     # Atribui o usuário que modificou o item
            else:                           # Se o item está sendo criado, você pode adicionar lógica para criação também
                self.modified_by = user
        
        # Converte todos os campos relevantes para maiúsculas
        self.name = self.name.upper()
        self.brand = self.brand.upper()
        self.model = self.model.upper()
        self.category = self.category.upper()
        self.sub_category = self.sub_category.upper()
        
        super().save(*args, **kwargs)

# Mudança de modelo de dados no Tombo 
class ItemTombo(models.Model):
    item = models.ForeignKey(Items, related_name='tombos', on_delete=models.CASCADE)
    tombo = models.CharField(max_length=200)

class ItemsAuditLog(models.Model):
    ACTION_CHOICES = [
        ('Criado', 'Criado'),
        ('Editado', 'Editado'),
        ('Deletado', 'Deletado'),
    ]

    action = models.CharField(max_length=50, choices=ACTION_CHOICES)
    item = models.ForeignKey('Items', on_delete=models.SET_NULL, null=True, blank=True)  # Item pode ser null
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)     # Usuário pode ser null
    item_deletado = models.CharField(max_length=300, blank=True, default='')
    timestamp = models.DateTimeField(default=timezone.now)                              # Data e hora da ação
    observation = models.CharField(max_length=300, blank=True, default='')              # Observação da ação
    changes = models.TextField(blank=True)                                              # Mudanças registradas

    def __str__(self):
        return f"{self.action} - {self.item or 'Item Deletado'} por {self.user} em {self.timestamp}"

    @staticmethod
    def track_changes(old_instance, new_instance):
        changes = {}
        if old_instance:
            # Comparar os campos para detectar mudanças
            for field in new_instance._meta.fields:
                field_name = field.name
                old_value = getattr(old_instance, field_name, None)
                new_value = getattr(new_instance, field_name, None)
                if isinstance(old_value, (datetime.date, datetime.datetime)):
                    old_value = old_value.isoformat()
                if isinstance(new_value, (datetime.date, datetime.datetime)):
                    new_value = new_value.isoformat()
                if old_value != new_value:
                    changes[field_name] = {'old': old_value, 'new': new_value}
        else:
            # Para novos itens, todos os valores são considerados novos
            for field in new_instance._meta.fields:
                field_name = field.name
                new_value = getattr(new_instance, field_name, None)
                if isinstance(new_value, (datetime.date, datetime.datetime)):
                    new_value = new_value.isoformat()
                changes[field_name] = {'old': None, 'new': new_value}
                
        return json.dumps(changes, ensure_ascii=False, indent=2, cls=DjangoJSONEncoder)
    
    def save(self, *args, **kwargs):
        user = kwargs.pop('user', None) 
        if user:
            self.user = user

        super().save(*args, **kwargs)