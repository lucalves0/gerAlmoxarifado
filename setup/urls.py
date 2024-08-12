from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

from items.views import (
  ItemsListView, 
  ItemsCreateView, 
  ItemsUpdateView, 
  ItemsDeleteView,
  LoadSubcategoriesView,
  ItemsRetirarStock,
  ItemsSubMaterialInstalacao,
  ItemsSubInformatica,
  ItemsSubDescarte,
  ItemsSubMaterialConsumo,
  ItemsSubFerramentas
)

urlpatterns = [
  path("", ItemsListView.as_view(template_name="items/items_main.html"), name="items_main"),
  path('login/', auth_views.LoginView.as_view(template_name='registration/login.html'), name='login'),
  path('logout/', auth_views.LogoutView.as_view(template_name='todos/templates/registration/logged_out.html'), name='logout'),
  path('create/', ItemsCreateView.as_view(), name="items_create"),
  path('update/<int:pk>', ItemsUpdateView.as_view(), name="items_update"),
  path('delete/<int:pk>', ItemsDeleteView.as_view(), name="items_delete"),
  path('ajax/load-subcategories/', LoadSubcategoriesView.as_view(), name='ajax-load-subcategories'),
  path('retirar/<int:pk>', ItemsRetirarStock.as_view(), name="items_form_retirar"),
  path('items-material-instalacao/<str:category>/', ItemsSubMaterialInstalacao.as_view(template_name="items/pag_subs_category/items_material_instalacao.html"), name="items_material_instalacao"),
  path('items-informatica/<str:category>/', ItemsSubInformatica.as_view(template_name="items/pag_subs_category/items_informatica.html"), name="items_informatica"),
  path('items-descarte/<str:category>/', ItemsSubDescarte.as_view(template_name="items/pag_subs_category/items_descarte.html"), name="items_descarte"),
  path('items-material-consumo/<str:category>/', ItemsSubMaterialConsumo.as_view(template_name="items/pag_subs_category/items_material_consumo.html"), name="items_material_consumo"),
  path('items-ferramentas/<str:category>/', ItemsSubFerramentas.as_view(template_name="items/pag_subs_category/items_ferramentas.html"), name="items_ferramentas")
]
