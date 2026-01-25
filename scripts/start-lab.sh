#!/bin/bash
# Kali Lab Startup Script for Linux/Mac
# Usage: ./scripts/start-lab.sh [network-mode]
# Network modes: lab (default), host, bridge

NETWORK_MODE="${1:-lab}"

# Validate network mode
if [[ ! "$NETWORK_MODE" =~ ^(lab|host|bridge)$ ]]; then
    echo "❌ Error: Invalid network mode '$NETWORK_MODE'"
    echo "   Valid options: lab (default), host, bridge"
    exit 1
fi

echo "═══════════════════════════════════════════════════════════"
echo "  Ethical Hacking Lab - NTWK290-5"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Check if Docker is running
if ! docker info &>/dev/null; then
    echo "❌ Error: Docker is not running!"
    echo "   Please start Docker and try again."
    exit 1
fi

# Start vulnerable targets if using lab mode
if [ "$NETWORK_MODE" = "lab" ]; then
    echo "🎯 Starting vulnerable targets (DVWA, Juice Shop)..."
    docker compose up -d dvwa juice-shop
    sleep 2
fi

# Start Kali container with appropriate network mode
echo "🐉 Starting Kali Linux container..."

case "$NETWORK_MODE" in
    host)
        echo "   Network mode: HOST (full host network access)"
        docker compose run --rm --network host kali /bin/bash
        ;;
    bridge)
        echo "   Network mode: BRIDGE (isolated)"
        docker compose run --rm kali /bin/bash
        ;;
    lab)
        echo "   Network mode: LAB (connected to targets on pentest-net)"
        docker compose run --rm kali /bin/bash
        ;;
esac

echo ""
echo "👋 Exited Kali container"

# Ask if user wants to stop targets
if [ "$NETWORK_MODE" = "lab" ]; then
    echo ""
    read -p "Stop vulnerable targets? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "⏹️  Stopping targets..."
        docker compose stop dvwa juice-shop
    else
        echo "ℹ️  Targets still running. Use 'docker compose down' to stop them."
    fi
fi
