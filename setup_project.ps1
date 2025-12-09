# Script de création de la structure du projet Recommender System (Windows)
# Exécute ce script dans ton dossier recommender-system

Write-Host "🚀 Création de la structure du projet Recommender System..." -ForegroundColor Green
Write-Host "=============================================================" -ForegroundColor Green

# Créer la structure de dossiers
Write-Host "📁 Création des dossiers..." -ForegroundColor Yellow

# Services principaux
New-Item -ItemType Directory -Force -Path "user_service\backend" | Out-Null
New-Item -ItemType Directory -Force -Path "user_service\frontend" | Out-Null
New-Item -ItemType Directory -Force -Path "user_service\middleware" | Out-Null
New-Item -ItemType Directory -Force -Path "user_service\tests" | Out-Null

New-Item -ItemType Directory -Force -Path "product_service\backend" | Out-Null
New-Item -ItemType Directory -Force -Path "product_service\frontend" | Out-Null
New-Item -ItemType Directory -Force -Path "product_service\middleware" | Out-Null
New-Item -ItemType Directory -Force -Path "product_service\tests" | Out-Null

New-Item -ItemType Directory -Force -Path "recommendation_service\backend" | Out-Null
New-Item -ItemType Directory -Force -Path "recommendation_service\frontend" | Out-Null
New-Item -ItemType Directory -Force -Path "recommendation_service\middleware" | Out-Null
New-Item -ItemType Directory -Force -Path "recommendation_service\tests" | Out-Null

# Infrastructure
New-Item -ItemType Directory -Force -Path "terraform" | Out-Null
New-Item -ItemType Directory -Force -Path "tests" | Out-Null
New-Item -ItemType Directory -Force -Path "docs" | Out-Null
New-Item -ItemType Directory -Force -Path "data\raw" | Out-Null
New-Item -ItemType Directory -Force -Path "data\processed" | Out-Null
New-Item -ItemType Directory -Force -Path "data\models" | Out-Null
New-Item -ItemType Directory -Force -Path "scripts" | Out-Null

Write-Host "✅ Dossiers créés" -ForegroundColor Green

# Créer les fichiers de configuration
Write-Host "📄 Création des fichiers de configuration..." -ForegroundColor Yellow

# .gitignore
@"
# Python
__pycache__/
*.py[cod]
*`$py.class
*.so
.Python
env/
venv/
ENV/
.venv
*.egg-info/
dist/
build/

# Virtual environments
venv/
ENV/
env/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Docker
*.log

# Terraform
*.tfstate
*.tfstate.*
.terraform/
*.tfvars

# Data
data/raw/*
data/processed/*
!data/raw/.gitkeep
!data/processed/.gitkeep

# Models
*.h5
*.pkl
*.joblib
data/models/*
!data/models/.gitkeep

# Environment variables
.env
.env.local

# Jupyter Notebooks
.ipynb_checkpoints/
*.ipynb

# Coverage
.coverage
htmlcov/

# Pytest
.pytest_cache/
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8

# README.md principal
@"
# 🛍️ E-Commerce Recommender System

Système de recommandation intelligent pour e-commerce basé sur une architecture microservices.

## 📋 Description

Ce projet implémente un système de recommandation utilisant le Deep Learning (TensorFlow) pour suggérer des produits aux utilisateurs en fonction de leur historique et comportement.

## 🏗️ Architecture

Le système est composé de 3 microservices :

- **User Service** : Gestion des utilisateurs (CRUD)
- **Product Service** : Gestion des produits et catalogue
- **Recommendation Service** : Moteur de recommandation basé sur IA

## 🚀 Technologies

- **Backend** : Python (Flask/FastAPI), TensorFlow/Keras
- **Base de données** : PostgreSQL / SQLite
- **Containerisation** : Docker, Docker Compose
- **Cloud** : AWS / GCP / Azure
- **CI/CD** : GitHub Actions / GitLab CI
- **Monitoring** : Prometheus, Grafana / CloudWatch
- **Tests** : Pytest, Coverage

## 📂 Structure du projet

``````
recommender-system/
├── user_service/           # Service de gestion des utilisateurs
├── product_service/        # Service de gestion des produits
├── recommendation_service/ # Service de recommandation IA
├── terraform/             # Infrastructure as Code
├── tests/                 # Tests d'intégration
├── data/                  # Données et modèles
├── docs/                  # Documentation
└── docker-compose.yml     # Orchestration des services
``````

## 🔧 Installation

### Prérequis

- Python 3.9+
- Docker & Docker Compose
- Git

### Installation locale

``````bash
# Cloner le repository
git clone https://github.com/TON_USERNAME/recommender-system.git
cd recommender-system

# Créer un environnement virtuel
python -m venv venv
venv\Scripts\activate

# Installer les dépendances
pip install -r requirements.txt
``````

### Lancer avec Docker

``````bash
# Construire et lancer tous les services
docker-compose up --build

# Arrêter les services
docker-compose down
``````

## 📊 Dataset

Nous utilisons le dataset **Amazon Reviews 2023** ou **RetailRocket** pour entraîner le modèle de recommandation.

## 🧪 Tests

``````bash
# Lancer tous les tests
pytest

# Avec couverture
pytest --cov=. --cov-report=html
``````

## 📈 Roadmap

- [x] Sprint 1 : Configuration initiale et environnement
- [x] Sprint 2 : Préparation des données et modèle IA
- [ ] Sprint 3 : Développement des microservices
- [ ] Sprint 4 : Dockerisation et tests d'intégration
- [ ] Sprint 5 : Déploiement cloud et monitoring

## 👥 Équipe

- **Développeur 1** : Backend / IA
- **Développeur 2** : DevOps / Infrastructure

## 📝 Licence

MIT License
"@ | Out-File -FilePath "README.md" -Encoding UTF8

# docker-compose.yml
@"
version: '3.8'

services:
  user-service:
    build: ./user_service/backend
    container_name: user-service
    ports:
      - "5001:5001"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/users_db
      - FLASK_ENV=development
    depends_on:
      - db
    networks:
      - recommender-network
    volumes:
      - ./user_service/backend:/app

  product-service:
    build: ./product_service/backend
    container_name: product-service
    ports:
      - "5002:5002"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/products_db
      - FLASK_ENV=development
    depends_on:
      - db
    networks:
      - recommender-network
    volumes:
      - ./product_service/backend:/app

  recommendation-service:
    build: ./recommendation_service/backend
    container_name: recommendation-service
    ports:
      - "5003:5003"
    environment:
      - MODEL_PATH=/app/models/recommender_model.h5
      - USER_SERVICE_URL=http://user-service:5001
      - PRODUCT_SERVICE_URL=http://product-service:5002
    depends_on:
      - user-service
      - product-service
    networks:
      - recommender-network
    volumes:
      - ./recommendation_service/backend:/app
      - ./data/models:/app/models

  db:
    image: postgres:14-alpine
    container_name: postgres-db
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_MULTIPLE_DATABASES=users_db,products_db
    ports:
      - "5432:5432"
    networks:
      - recommender-network
    volumes:
      - postgres-data:/var/lib/postgresql/data

networks:
  recommender-network:
    driver: bridge

volumes:
  postgres-data:
"@ | Out-File -FilePath "docker-compose.yml" -Encoding UTF8

# requirements.txt
@"
# Web Frameworks
flask==3.0.0
fastapi==0.104.1
uvicorn==0.24.0

# Machine Learning
tensorflow==2.15.0
scikit-learn==1.3.2
pandas==2.1.3
numpy==1.26.2

# Database
psycopg2-binary==2.9.9
sqlalchemy==2.0.23

# Testing
pytest==7.4.3
pytest-cov==4.1.0
pytest-mock==3.12.0

# Data Processing
joblib==1.3.2

# API Documentation
flask-swagger-ui==4.11.1

# Environment
python-dotenv==1.0.0

# Utilities
requests==2.31.0
"@ | Out-File -FilePath "requirements.txt" -Encoding UTF8

# .env.example
@"
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/recommender_db

# Services URLs
USER_SERVICE_URL=http://localhost:5001
PRODUCT_SERVICE_URL=http://localhost:5002
RECOMMENDATION_SERVICE_URL=http://localhost:5003

# Model
MODEL_PATH=./data/models/recommender_model.h5

# AWS (si utilisé)
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1

# Flask
FLASK_ENV=development
FLASK_DEBUG=1
"@ | Out-File -FilePath ".env.example" -Encoding UTF8

# Créer les .gitkeep
New-Item -ItemType File -Force -Path "data\raw\.gitkeep" | Out-Null
New-Item -ItemType File -Force -Path "data\processed\.gitkeep" | Out-Null
New-Item -ItemType File -Force -Path "data\models\.gitkeep" | Out-Null

Write-Host ""
Write-Host "=============================================================" -ForegroundColor Green
Write-Host "✅ Structure du projet créée avec succès!" -ForegroundColor Green
Write-Host "=============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "📂 Structure créée:" -ForegroundColor Cyan
Write-Host "   ├── user_service/"
Write-Host "   ├── product_service/"
Write-Host "   ├── recommendation_service/"
Write-Host "   ├── terraform/"
Write-Host "   ├── tests/"
Write-Host "   ├── data/"
Write-Host "   ├── docker-compose.yml"
Write-Host "   └── README.md"
Write-Host ""
Write-Host "🚀 Prochaines étapes:" -ForegroundColor Yellow
Write-Host "   1. python -m venv venv"
Write-Host "   2. venv\Scripts\activate"
Write-Host "   3. pip install -r requirements.txt"
Write-Host "   4. Copier .env.example vers .env et configurer"
Write-Host ""