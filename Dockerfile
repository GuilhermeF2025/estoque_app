# Usa imagem oficial do Python
FROM python:3.10-slim

# Evita criação de arquivos .pyc
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Define diretório de trabalho
WORKDIR /app

# Copia dependências e instala
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copia o restante do projeto
COPY . .

# Comando para iniciar com Gunicorn
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]

ENV DJANGO_SETTINGS_MODULE=${DJANGO_SETTINGS_MODULE}
