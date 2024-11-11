from django.urls import path
from django.contrib.auth import views as auth_views

from items.views import (
  ItemsListView, 
  ItemsCreateView, 
  ItemsUpdateView, 
  ItemsDeleteView,
  ItemsRetirarStock,
  ItemsSubMaterialInstalacao,
  ItemsSubInformatica,
  ItemsSubDescarte,
  ItemsSubMaterialConsumo,
  ItemsSubFerramentas,
  ItemsAuditLogView,
  SomeView,
  DashboardView,
  ItemsFichaTecnica,
  LoadSubcategoriesView,
  ItemSearchView,
)


urlpatterns = [
  path("", ItemsListView.as_view(template_name="items/items_main.html"), name="items_main"),
  path('login/', auth_views.LoginView.as_view(template_name='registration/login.html'), name='login'),
  path('logout/', auth_views.LogoutView.as_view(), name='logout'),
  path('create/', ItemsCreateView.as_view(), name="items_create"),
  path('update/<str:pk>/', ItemsUpdateView.as_view(), name="items_update"),
  path('delete/<str:pk>/', ItemsDeleteView.as_view(), name="items_delete"),
  path('ficha/<str:pk>/', ItemsFichaTecnica.as_view(), name="items_ficha"),
  path('search/', ItemSearchView.as_view(), name = 'items_search'),
  path('retirar/<str:id>/', ItemsRetirarStock.as_view(), name="items_form_retirar"),
  path('items-audit-log/', ItemsAuditLogView.as_view(), name='items-auditLog'),
  path('item/<str:hash>/update/', SomeView.as_view(), name='item_update'),
  path('dashboard/data', DashboardView.as_view(), name='items_dashboard'),
  path('ajax-load-subcategories/', LoadSubcategoriesView.as_view(), name='ajax-load-subcategories'),
  path('items-material-instalacao/<str:category>/', ItemsSubMaterialInstalacao.as_view(template_name="items/pag_subs_category/items_material_instalacao.html"), name="items_material_instalacao"),
  path('items-informatica/<str:category>/', ItemsSubInformatica.as_view(template_name="items/pag_subs_category/items_informatica.html"), name="items_informatica"),
  path('items-descarte/<str:category>/', ItemsSubDescarte.as_view(template_name="items/pag_subs_category/items_descarte.html"), name="items_descarte"),
  path('items-material-consumo/<str:category>/', ItemsSubMaterialConsumo.as_view(template_name="items/pag_subs_category/items_material_consumo.html"), name="items_material_consumo"),
  path('items-ferramentas/<str:category>/', ItemsSubFerramentas.as_view(template_name="items/pag_subs_category/items_ferramentas.html"), name="items_ferramentas"),
 
]