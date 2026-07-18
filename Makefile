.PHONY: help build up down logs clean install dev test

help:
	@echo "APSAN Management System - Comandos disponíveis:"
	@echo ""
	@echo "make build       - Build das imagens Docker"
	@echo "make up          - Iniciar todos os serviços"
	@echo "make down        - Parar todos os serviços"
	@echo "make logs        - Ver logs de todos os serviços"
	@echo "make clean       - Limpar containers e volumes"
	@echo "make install     - Instalar dependências localmente"
	@echo "make dev         - Iniciar em desenvolvimento (local)"
	@echo "make test        - Rodar testes"
	@echo "make db-setup    - Configurar banco de dados"
	@echo ""

build:
	@echo "🔨 Building Docker images..."
	docker-compose build

up:
	@echo "🚀 Starting APSAN services..."
	docker-compose up -d
	@echo "✅ Services started!"
	@echo "Frontend: http://localhost:3000"
	@echo "Backend: http://localhost:3001"
	@echo "API Docs: http://localhost:3001/api/docs"

down:
	@echo "🛑 Stopping APSAN services..."
	docker-compose down

logs:
	@echo "📋 Showing logs..."
	docker-compose logs -f

clean:
	@echo "🧹 Cleaning up..."
	docker-compose down -v
	@echo "✅ Cleaned!"

install:
	@echo "📦 Installing dependencies..."
	cd backend && npm install
	cd ../frontend && npm install
	@echo "✅ Dependencies installed!"

dev:
	@echo "🎯 Starting development environment..."
	@echo "Starting backend..."
	cd backend && npm run dev &
	@echo "Starting frontend..."
	cd frontend && npm start

test:
	@echo "🧪 Running tests..."
	cd backend && npm test
	cd ../frontend && npm test

db-setup:
	@echo "🗄️ Setting up database..."
	createdb apsan_management 2>/dev/null || true
	psql -U postgres -c "CREATE USER apsan_user WITH PASSWORD 'apsan_password';" 2>/dev/null || true
	psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE apsan_management TO apsan_user;" 2>/dev/null || true
	@echo "✅ Database setup complete!"

db-seed:
	@echo "🌱 Seeding database..."
	cd backend && npm run seed

migrate:
	@echo "🔄 Running migrations..."
	cd backend && npm run migrate

health:
	@echo "🏥 Checking health..."
	curl -s http://localhost:3001/api/health | jq .
	@echo ""

info:
	@echo "APSAN Management System"
	@echo "========================"
	@echo ""
	docker-compose ps
	@echo ""
