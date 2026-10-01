# AI-Trader - Android Termux Deployment & Mobile Guide

Ce guide explique comment déployer et exécuter **AI-Trader** directement depuis votre smartphone Android (ex. **OnePlus N100**) en utilisant **Termux**.

---

## 📱 Déploiement sur Android (Termux)

### 1. Prérequis
1. Téléchargez et installez **Termux** (de préférence depuis [F-Droid](https://f-droid.org/packages/com.termux/)).
2. Ouvrez l'application Termux.

### 2. Cloner / Copier le dépôt AI-Trader
Dans Termux, clonez votre dépôt ou décompressez les fichiers :
```bash
git clone https://github.com/votre-compte/AI-Trader.git
cd AI-Trader
```

### 3. Exécuter le script de déploiement automatique
Lancez le script d'installation et de démarrage rapide :
```bash
chmod +x deploy_android.sh
./deploy_android.sh
```

Le script va automatiquement :
- Mettre à jour les paquets Termux et installer `python3`, `nodejs`, `npm`, et outils de compilation.
- Installer les dépendances Python (`fastapi`, `uvicorn`, `pydantic`, `yfinance`, etc.).
- Installer les dépendances du frontend React et générer les fichiers de production avec Vite.
- Initialiser la base de données SQLite locale (`clawtrader.db`).
- Démarrer le serveur backend et frontend sur `0.0.0.0:8000`.

### 4. Accéder à AI-Trader depuis votre mobile
Une fois le serveur démarré, ouvrez votre navigateur Chrome ou Firefox sur votre OnePlus N100 à l'adresse :
```
http://localhost:8000
```
ou `http://127.0.0.1:8000`.

---

## 🔌 Liaison avec Binance & Bitget

### Comment cela fonctionne-t-il ?
**AI-Trader** est une plateforme de trading **Agent-Native** et de **Copy Trading / Signal Sync**.
- Les échanges réels tels que **Binance**, **Bitget**, **Coinbase** ou **Interactive Brokers** sont connectés via la compétence **Trade Sync** (`skills/tradesync/SKILL.md`).
- Votre Agent (ou un bot en Python/OpenClaw) lit l'API de votre compte Binance ou Bitget via vos clés API d'échange, puis pousse automatiquement vos positions et opérations sur AI-Trader (`POST /api/signals/realtime`).
- Vos followers sur AI-Trader reçoivent vos métriques de performance et vos signaux en temps réel pour le copy-trading.

---

## 🚀 Fonctionnalités PWA / Mobile
L'interface utilisateur web React de AI-Trader est 100% optimisée pour les écrans tactiles et smartphones (navigation par menu tiroir latéral, cibles tactiles de 44px minimum, tableaux réactifs).
