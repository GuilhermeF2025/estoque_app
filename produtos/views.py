from django.shortcuts import render, redirect
from rest_framework import viewsets
from .models import Produto
from .forms import ProdutoForm
from .serializers import ProdutoSerializer

class ProdutoViewSet(viewsets.ModelViewSet):
    queryset = Produto.objects.all()
    serializer_class = ProdutoSerializer


def cadastrar(request):
    if request.method == 'POST':
        form = ProdutoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('home')
    else:
        form = ProdutoForm()
    return render(request, 'produtos/cadastrar.html', {'form': form})


def home(request):
    produtos = Produto.objects.all()

    # Exibir o primeiro produto (ou personalize)
    produto = produtos.first()

    # Dados para o gráfico
    labels = [p.nome for p in produtos]
    data = [p.quantidade for p in produtos]

    context = {
        'produto': produto,
        'labels': labels,
        'data': data,
    }
    return render(request, 'produtos/home.html', context)
