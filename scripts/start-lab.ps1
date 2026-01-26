# Kali Lab Startup Script for Windows
# Usage: .\scripts\start-lab.ps1 [network-mode]
# Network modes: lab (default), host, bridge

param(
    [ValidateSet('lab', 'host', 'bridge')]
    [string]$NetworkMode = 'lab'
)

Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "  Ethical Hacking Lab - NTWK290-5" -ForegroundColor Cyan
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
$dockerRunning = docker info 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error: Docker is not running!" -ForegroundColor Red
    Write-Host "   Please start Docker Desktop and try again." -ForegroundColor Yellow
    exit 1
}

# Start vulnerable targets if using lab mode
if ($NetworkMode -eq 'lab') {
    Write-Host "Starting vulnerable targets (DVWA, Juice Shop)..." -ForegroundColor Green
    docker compose up -d dvwa juice-shop
    Start-Sleep -Seconds 2
}

# Start Kali container with appropriate network mode
Write-Host "Starting Kali Linux container..." -ForegroundColor Green

switch ($NetworkMode) {
    'host' {
        Write-Host "   Network mode: HOST (full host network access)" -ForegroundColor Yellow
        docker compose run --rm --network host kali /bin/bash
    }
    'bridge' {
        Write-Host "   Network mode: BRIDGE (isolated)" -ForegroundColor Yellow
        docker compose run --rm kali /bin/bash
    }
    'lab' {
        Write-Host "   Network mode: LAB (connected to targets on pentest-net)" -ForegroundColor Yellow
        docker compose run --rm kali /bin/bash
    }
}

Write-Host ""
Write-Host "Exited Kali container" -ForegroundColor Cyan

# Ask if user wants to stop targets
if ($NetworkMode -eq 'lab') {
    Write-Host ""
    $response = Read-Host "Stop vulnerable targets? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Write-Host "Stopping targets..." -ForegroundColor Yellow
        docker compose stop dvwa juice-shop
    } else {
        Write-Host "INFO: Targets still running. Use 'docker compose down' to stop them." -ForegroundColor Cyan
    }
}
