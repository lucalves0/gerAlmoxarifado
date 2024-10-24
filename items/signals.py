from django.db.models.signals import post_save, post_delete, pre_save, pre_delete
from django.dispatch import receiver
from items.models import Items, ItemsAuditLog
from .middleware import get_current_user

# Captura o estado antigo da instância antes de salvar
@receiver(pre_save, sender=Items)
def capture_old_instance(sender, instance, **kwargs):
    if instance.pk:  # Verifica se o objeto já foi salvo antes
        try:
            instance._old_instance = sender.objects.get(pk=instance.pk)
        except sender.DoesNotExist:
            instance._old_instance = None
    else:
        instance._old_instance = None

    # Captura o usuário logado
    user = get_current_user()
    instance._save_user = user if user and user.is_authenticated else None

# Criação/Atualização de log de auditoria após salvar
@receiver(post_save, sender=Items)
def log_save_action(sender, instance, created, **kwargs):
    user = get_current_user()

    if created:
        # Se o item foi criado
        action = 'Criado'
        item_deletado = f"{instance.name}"
        observation = f"Item <b>{instance.name}</b> criado."

    else:
        # Se o item foi atualizado
        old_instance = getattr(instance, '_old_instance', None)  # Instância antiga capturada no pre_save
        if old_instance and instance.quantity < old_instance.quantity:
            action = f'Retirado: {old_instance.quantity - instance.quantity} UN'
            item_deletado = f"{instance.name}"
            observation = f"Quantidade do item <b>{instance.name}</b> reduzida de {old_instance.quantity} para {instance.quantity}."
        else:
            action = 'Editado'
            item_deletado = f"{instance.name}"
            observation = f"Item <b>{instance.name}</b> editado."
    
    # Criar o registro de log no audit log
    ItemsAuditLog.objects.create(
        action=action,
        item=instance,
        user=user or instance._save_user,  # Garantir que user não é None
        item_deletado=item_deletado,
        observation=observation,
    )

# Captura as informações antes de deletar (para auditoria de deleção)
@receiver(pre_delete, sender=Items)
def capture_delete_data(sender, instance, **kwargs):
    # Armazena informações relevantes antes da exclusão
    instance._delete_user = get_current_user()  # Usa o usuário logado do middleware
    instance._delete_name = instance.name

# Criação de log de auditoria após exclusão
@receiver(post_delete, sender=Items)
def log_delete_action(sender, instance, **kwargs):
    item_name = getattr(instance, '_delete_name', 'Nome Desconhecido')
    user = getattr(instance, '_delete_user', None)
    
    # Criar o registro de log no audit log sem a referência ao item (pois ele já foi deletado)
    ItemsAuditLog.objects.create(
        action='Deletado',
        item=None,  # O item foi deletado, então não podemos referenciá-lo
        user=user,
        item_deletado=item_name,
        observation=f"Item '{item_name}' deletado.",
        changes='{"item_deleted": true}'  # Informação sobre a deleção
    )
