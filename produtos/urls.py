from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProdutoViewSet, home, cadastrar
from produtos import views

router = DefaultRouter()
router.register(r'produtos', ProdutoViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
    path('', home, name='home'),
    path('cadastrar/', views.cadastrar, name='cadastrar'),

]
