# Imagem base leve e atualizada
FROM python:3.13-slim

# Define diretório de trabalho
WORKDIR /app

# Variáveis de ambiente / Evita criação de arquivos .pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala dependências Python
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copia o projeto
COPY . .

# Coleta arquivos estáticos (opcional para produção)
RUN python manage.py collectstatic --noinput

# Define o comando padrão para produção
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
