from django.apps import AppConfig

class ItemsConfig(AppConfig):
    name = 'items'

    def ready(self):
        import items.signals  # Importa os sinais para que sejam registrados
