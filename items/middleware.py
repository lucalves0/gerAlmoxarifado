import threading

# Criando um objeto thread-local para armazenar o usuário
_thread_locals = threading.local()

# Função para obter o usuário logado
def get_current_user():
    return getattr(_thread_locals, 'user', None)

# Middleware para armazenar o usuário logado em thread-local
class CurrentUserMiddleware:
    def __init__(self, get_response):
      self.get_response = get_response

    def __call__(self, request):
      _thread_locals.user = request.user  # Armazena o usuário logado
      response = self.get_response(request)
      return response
