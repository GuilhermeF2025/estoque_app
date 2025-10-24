from rest_framework import viewsets
from .models import Produto
from .serializers import ProdutoSerializer
from django.shortcuts import render


class ProdutoViewSet(viewsets.ModelViewSet):
    queryset = Produto.objects.all()
    serializer_class = ProdutoSerializer


def home(request):
    produtos = Produto.objects.all()
    return render(request, 'produtos/home.html', {'produtos': produtos})
