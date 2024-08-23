from django.apps import AppConfig

class ItemsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "items"
    verbose_name = "Items"

    def ready(self):
        # Importa o módulo de sinais aqui para garantir que os sinais sejam registrados
        import items.signals
