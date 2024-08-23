import datetime
import json
from django.db import models
from django.conf import settings
from django.forms import ValidationError
from django.utils import timezone
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from django.core.serializers.json import DjangoJSONEncoder

User = settings.AUTH_USER_MODEL  # Importar User do settings para evitar ciclos


class Items(models.Model):
    name = models.CharField(verbose_name="Nome", max_length=100, null=False, blank=False, default='')
    brand = models.CharField(verbose_name="Marca", max_length=100, default='')
    model = models.CharField(verbose_name="Modelo", max_length=100, blank=False, default='')
    location = models.CharField(verbose_name="Localização", max_length=100, null=False, blank=False, default='')
    category = models.CharField(verbose_name="Categoria", max_length=100, default='')
    sub_category = models.CharField(verbose_name="Sub-Categoria", max_length=100, default='')
    quantity = models.PositiveIntegerField(verbose_name="Quantidades de Unidades")
    create_at = models.DateField(auto_now_add=True, null=False, blank=False)
    finished_at = models.DateField(null=True)
    locality = models.CharField(verbose_name="Localidade", max_length=100, blank=False, default='')
    observation = models.CharField(verbose_name="Observação", max_length=300, default='', blank=True)
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
        if self.pk:  # Se já existe uma instância (edição)
            self.modified_by = kwargs.pop('name', None)  # Defina o usuário, se fornecido

        # Converte todos os campos relevantes para maiúsculas
        self.name = self.name.upper()
        self.brand = self.brand.upper()
        self.model = self.model.upper()
        self.location = self.location.upper()
        self.category = self.category.upper()
        self.sub_category = self.sub_category.upper()
        self.locality = self.locality.upper()
        self.observation = self.observation.upper()
        
        super().save(*args, **kwargs)

class ItemsAuditLog(models.Model):
    ACTION_CHOICES = [
        ('Criado', 'Criado'),
        ('Editado', 'Editado'),
        ('Deletado', 'Deletado'),
    ]

    action = models.CharField(max_length=50, choices=ACTION_CHOICES)
    item = models.ForeignKey('Items', on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    timestamp = models.DateTimeField(default=timezone.now)
    observation = models.CharField(max_length=300, blank=True, default='')
    changes = models.TextField(blank=True)

    def __str__(self):
        return f"{self.action} - {self.item} por {self.user} em {self.timestamp}"

    
    @staticmethod
    def track_changes(old_instance, new_instance):
        changes = {}
        if old_instance:
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
            # Novos itens não têm valores antigos para comparação
            for field in new_instance._meta.fields:
                field_name = field.name
                new_value = getattr(new_instance, field_name, None)
                if isinstance(new_value, (datetime.date, datetime.datetime)):
                    new_value = new_value.isoformat()
                changes[field_name] = {'old': None, 'new': new_value}
                
        return json.dumps(changes, ensure_ascii=False, indent=2, cls=DjangoJSONEncoder)

@receiver(post_save, sender=Items)
def log_save_action(sender, instance, created, **kwargs):
    if created:
        action = 'Criado'
        observation = f"Item '{instance.name}' criado."
        changes = ItemsAuditLog.track_changes(None, instance)  # Todas as mudanças são novas
    else:
        old_instance = sender.objects.get(pk=instance.pk)  # Obter instância anterior ao salvamento
        action = 'Editado'
        observation = f"Item '{instance.name}' editado."
        changes = ItemsAuditLog.track_changes(old_instance, instance)  # Comparar as mudanças

    ItemsAuditLog.objects.create(
        action=action,
        item=instance,
        user=instance.modified_by,  # Assegure-se de que 'modified_by' seja configurado corretamente
        observation=observation,
        changes=changes  # Armazenar as mudanças no log
    )

@receiver(post_delete, sender=Items)
def log_delete_action(sender, instance, **kwargs):
    ItemsAuditLog.objects.create(
        action='Deletado',
        item=instance,
        user=instance.modified_by,  # Assegure-se de que 'modified_by' seja configurado corretamente
        observation=f"Item '{instance.name}' deletado."
    )