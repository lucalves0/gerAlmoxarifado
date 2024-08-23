from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from items.models import Items, ItemsAuditLog

@receiver(post_save)
def log_save(sender, instance, created, **kwargs):
    # Verifique se o modelo que disparou o sinal não é o ItemsAuditLog
    if sender == ItemsAuditLog:
        return

    action = "Criação" if created else "Atualização"

    # Obter o usuário atual. Ajuste conforme necessário para obter o usuário atual da requisição.
    user = getattr(instance, 'modified_by', None)  # Altere isso para obter o usuário real se necessário

    # Verifique se a instância é do modelo Items
    if isinstance(instance, Items):
        ItemsAuditLog.objects.create(
            user=user,
            action=action,
            item=instance,
            observation=f"Item '{instance.name}' {action.lower()}.",  # Altere a observação conforme necessário
            changes=ItemsAuditLog.track_changes(None, instance)  # Registra as mudanças se necessário
        )

@receiver(post_delete)
def log_delete(sender, instance, **kwargs):
    # Verifique se o modelo que disparou o sinal não é o ItemsAuditLog
    if sender == ItemsAuditLog:
        return

    # Obter o usuário atual. Ajuste conforme necessário para obter o usuário real da requisição.
    user = getattr(instance, 'modified_by', None)  # Altere isso para obter o usuário real se necessário

    if isinstance(instance, Items):
        ItemsAuditLog.objects.create(
            user=user,
            action="Exclusão",
            item=instance,
            observation=f"Item '{instance.name}' excluído."  # Altere a observação conforme necessário
        )