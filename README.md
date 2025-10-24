# 📦 Estoque App

Aplicação web para gerenciamento de estoque, construída com Django e PostgreSQL, containerizada com Docker para facilitar o desenvolvimento e o deploy.

---

## 🚀 Tecnologias

- Python 3.13
- Django 5.2
- PostgreSQL 15
- Docker & Docker Compose
- python-decouple
- Gunicorn (produção)

---

## ⚙️ Pré-requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- Git (opcional)

---

## 🧪 Ambiente de desenvolvimento

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/estoque_app.git
cd estoque_app

2. Crie o arquivo .env
env
DJANGO_SETTINGS_MODULE=core.settings.dev
DEBUG=True

DB_NAME=estoque
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=db
DB_PORT=5432

DJANGO_ENV=dev
Esse mesmo arquivo .env pode ser adaptado para produção alterando os valores conforme necessário.

3. Suba os containers
bash
docker-compose -f docker-compose.dev.yml up --build
O arquivo docker-compose.yml é usado tanto para desenvolvimento quanto para produção. Você pode configurar perfis ou variáveis para diferenciar os ambientes.

✅ Outrps passo: subir os containers
docker-compose -f docker-compose.dev.yml build --no-cache
docker-compose -f docker-compose.dev.yml up --build

✅ Verificar se os containers estão rodando
docker ps
docker-compose -f docker-compose.dev.yml up -d

🧪 Teste de erros percistentes
docker-compose -f docker-compose.dev.yml config
Esse comando valida a estrutura do arquivo. Se passar, você pode rodar:
docker-compose -f docker-compose.dev.yml up --build


4. Aplique as migrações
bash
docker-compose -f docker-compose.dev.yml exec web python manage.py migrate

5. Crie um superusuário
bash
docker-compose -f docker-compose.dev.yml exec web python manage.py createsuperuser

6. Acesse a aplicação
App: http://localhost:8000
Admin: http://localhost:8000/admin

---

## 🚀 Aplicação
🏗️ Deploy em produção
1. Ajuste o .env
Altere os valores para refletir o ambiente de produção:

env
DJANGO_SETTINGS_MODULE=core.settings.prod
DEBUG=False

DB_NAME=estoque
DB_USER=postgres
DB_PASSWORD=senha-segura
DB_HOST=db
DB_PORT=5432

DJANGO_ENV=prod
2. Configure o entrypoint.sh
O script já aplica migrações, coleta arquivos estáticos e pode iniciar o servidor Gunicorn.

3. Suba os containers
bash
docker-compose -f docker-compose.yml up --build

📁 Estrutura do projeto
Código
estoque_app/
├── core/
│   ├── settings/
│   │   ├── base.py
│   │   ├── dev.py
│   │   └── prod.py
│   ├── urls.py
│   └── wsgi.py
├── static/
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh
├── requirements.txt
└── .env
✅ Comandos úteis
bash
# Acessar o container web
docker-compose exec web bash

# Aplicar migrações
docker-compose exec web python manage.py migrate

# Criar superusuário
docker-compose exec web python manage.py createsuperuser

# Coletar arquivos estáticos
docker-compose exec web python manage.py collectstatic --noinput
📌 Observações
O volume do banco de dados é persistente, então você não perde dados ao reconstruir os containers.

O script entrypoint.sh adapta o comportamento conforme o valor da variável DJANGO_ENV.

Para deploy em nuvem, recomenda-se configurar variáveis de ambiente seguras e usar um servidor WSGI como Gunicorn.