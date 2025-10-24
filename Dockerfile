# Imagem base leve e atualizada
FROM python:3.13-slim

# Define diretório de trabalho
WORKDIR /app

# Variáveis de ambiente padrão
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

# O comando será definido no docker-compose (runserver ou gunicorn)
