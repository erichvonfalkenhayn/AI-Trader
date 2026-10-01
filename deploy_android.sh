#!/usr/bin/env bash
# ==============================================================================
# AI-Trader Android / Termux Deployment Script
# Target Device: OnePlus N100 & Android Termux Environment
# ==============================================================================

set -e

echo "🚀 Starting AI-Trader deployment setup for Android (Termux)..."

# 1. Update Termux packages and install prerequisites
if command -v pkg &> /dev/null; then
  echo "📦 Updating Termux package repository and installing dependencies..."
  pkg update -y || true
  pkg install -y python nodejs git build-essential libffi libxml2 libxslt openssl clang
else
  echo "⚠️ Warning: 'pkg' package manager not found. Ensure Python 3.9+ and Node.js 18+ are installed."
fi

# 2. Python Environment Setup
echo "🐍 Setting up Python backend dependencies..."
python3 -m pip install --upgrade pip setuptools wheel
if [ -f "requirements.txt" ]; then
  pip install -r requirements.txt
elif [ -f "service/server/requirements.txt" ]; then
  pip install -r service/server/requirements.txt
fi

# Install core server dependencies if not already present
pip install fastapi uvicorn pydantic python-dotenv requests yfinance 2>/dev/null || true

# 3. Node.js Frontend Setup & Build
if [ -d "service/frontend" ]; then
  echo "⚡ Installing frontend dependencies and building production assets..."
  cd service/frontend
  npm install --legacy-peer-deps
  npm run build
  cd ../..
fi

# 4. Database Setup
echo "🗄️ Initializing SQLite database for mobile deployment..."
mkdir -p service/server/data
if [ ! -f ".env" ]; then
  cp .env.example .env 2>/dev/null || touch .env
  echo "ENVIRONMENT=development" >> .env
  echo "DATABASE_URL=" >> .env
  echo "DB_PATH=service/server/data/clawtrader.db" >> .env
fi

# 5. Start Application
echo "✅ Setup complete!"
echo "🌐 Starting AI-Trader Server on 0.0.0.0:8000 (accessible via mobile browser)..."
echo "👉 Access locally at http://localhost:8000 or http://127.0.0.1:8000"

export PYTHONPATH=service/server
exec python3 -m uvicorn service.server.main:app --host 0.0.0.0 --port 8000 --reload
