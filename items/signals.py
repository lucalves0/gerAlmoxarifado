from django.db.models.signals import post_save, post_delete, pre_save, pre_delete
from django.dispatch import receiver
from items.models import Items, ItemsAuditLog

# Captura o estado antigo da instância antes de salvar
@receiver(pre_save, sender=Items)
def capture_old_instance(sender, instance, **kwargs):
    if instance.pk:  # Se o item já existe, captura o estado antigo
        instance._old_instance = sender.objects.get(pk=instance.pk)
    else:
        instance._old_instance = None

# Criação/Atualização de log de auditoria após salvar
@receiver(post_save, sender=Items)
def log_save_action(sender, instance, created, **kwargs):
    if created:
        # Se o item foi criado
        action = 'Criado'
        item_deletado = f"{instance.name}"
        observation = f"Item '{instance.name}' criado."
        changes = ItemsAuditLog.track_changes(None, instance)  # Todas as mudanças são novas
    else:
        # Se o item foi atualizado
        old_instance = getattr(instance, '_old_instance', None)  # Instância antiga capturada no pre_save
        if old_instance and instance.quantity < old_instance.quantity:
            action = f'Retirado: {old_instance.quantity - instance.quantity} UN'
            item_deletado = f"{instance.name}"
            observation = f"Quantidade do item '{instance.name}' reduzida de {old_instance.quantity} para {instance.quantity}."
        else:
            action = 'Editado'
            item_deletado = f"{instance.name}"
            observation = f"Item '{instance.name}' editado."
        
        changes = ItemsAuditLog.track_changes(old_instance, instance)  # Comparar as mudanças

    # Verifica se o usuário está definido
    user = getattr(instance, 'modified_by', None)
    if user is None:
        print(f"AVISO: O usuário não está definido para o item '{instance.name}'.")

    # Criar o registro de log no audit log
    ItemsAuditLog.objects.create(
        action=action,
        item=instance,
        user=user,  # Garantir que user não é None
        item_deletado=item_deletado,
        observation=observation,
        changes=changes
    )

# Captura as informações antes de deletar (para auditoria de deleção)
@receiver(pre_delete, sender=Items)
def capture_delete_data(sender, instance, **kwargs):
    # Armazena informações relevantes antes da exclusão
    instance._delete_user = instance.modified_by
    instance._delete_name = instance.name

# Criação de log de auditoria após exclusão
@receiver(post_delete, sender=Items)
def log_delete_action(sender, instance, **kwargs):

    item_name = getattr(instance, '_delete_name', 'Nome Desconhecido')
    user = getattr(instance, '_delete_user', None)
    
    # Verifique se a referência ao item ainda está disponível
    item = Items.objects.filter(pk=instance.pk).first()

    # Criar o registro de log no audit log sem a referência ao item (pois ele já foi deletado)
    ItemsAuditLog.objects.create(
        action='Deletado',
        item=item,  # Tenta associar o item, se ainda estiver disponível
        user=user,
        item_deletado = f"{item_name}",
        observation=f"Item '{item_name}' deletado.",
        changes='{"item_deleted": true}'  # Informação sobre a deleção
    )