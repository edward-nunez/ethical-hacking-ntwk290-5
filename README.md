# Ethical Hacking Lab Kit - NTWK290-5

A Docker-based Kali Linux penetration testing lab environment for ethical hacking coursework. This kit provides a portable, containerized Kali Linux environment with essential tools, vulnerable target applications, and flexible networking options.

## 🚀 Features

- **Pre-configured Kali Linux** with `kali-linux-headless` and `kali-tools-top10` metapackages
- **Vulnerable targets** for practice: DVWA and OWASP Juice Shop
- **Flexible networking modes**: lab, host, or bridge
- **Persistent workspace** for labs, reports, and notes
- **Custom aliases and shortcuts** for common penetration testing tasks
- **Easy-to-use startup scripts** for Windows and Linux/Mac

## 📋 Prerequisites

- **Docker Desktop** installed and running
  - Windows: [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
  - Mac: [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)
  - Linux: [Docker Engine](https://docs.docker.com/engine/install/)
- At least **8GB RAM** available
- At least **15GB disk space** for images and tools

## 🏗️ Quick Start

### Option 1: Use Pre-built Image (Recommended)

Pull the pre-built image from Docker Hub:

```bash
docker pull <username>/kali-ntwk290-lab:latest
```

Then start the lab:

**Windows (PowerShell):**
```powershell
.\scripts\start-lab.ps1
```

**Linux/Mac:**
```bash
chmod +x scripts/start-lab.sh
./scripts/start-lab.sh
```

### Option 2: Build from Source

Clone this repository and build the image locally:

```bash
git clone https://github.com/<username>/ethical-hacking-ntwk290-5.git
cd ethical-hacking-ntwk290-5
docker compose build
```

Then start the lab using the scripts above.

## 🎯 Network Modes

The lab supports three networking modes for different use cases:

### Lab Mode (Default)
Connects Kali to the vulnerable targets on an isolated network.

**Windows:**
```powershell
.\scripts\start-lab.ps1 lab
```

**Linux/Mac:**
```bash
./scripts/start-lab.sh lab
```

**Use cases:**
- Practicing web application testing against DVWA or Juice Shop
- Learning exploitation in a safe environment
- Completing lab assignments with provided targets

### Host Mode
Gives Kali full access to the host's network.

**Windows:**
```powershell
.\scripts\start-lab.ps1 host
```

**Linux/Mac:**
```bash
./scripts/start-lab.sh host
```

**Use cases:**
- Scanning your local network
- Testing against external targets (with authorization)
- Using tools that require direct network access

**Note:** On Windows with Docker Desktop (WSL2), host mode connects to the WSL2 VM network, not directly to Windows.

### Bridge Mode
Isolates Kali on its own network (no target access).

**Windows:**
```powershell
.\scripts\start-lab.ps1 bridge
```

**Linux/Mac:**
```bash
./scripts/start-lab.sh bridge
```

**Use cases:**
- Learning tools without network access
- Offline exercises
- Testing scripts in isolation

## 🎯 Vulnerable Targets

The lab includes two pre-configured vulnerable web applications:

### DVWA (Damn Vulnerable Web Application)
- **URL:** http://localhost:8080
- **Internal IP:** 172.20.0.2
- **Default credentials:** admin / password
- **Purpose:** SQL injection, XSS, command injection, file upload vulnerabilities

### OWASP Juice Shop
- **URL:** http://localhost:3000
- **Internal IP:** 172.20.0.3
- **Purpose:** Modern web application vulnerabilities, API testing

Access targets directly from your browser or scan them from within Kali using the internal IPs.

## 📁 Workspace Structure

```
ethical-hacking-ntwk290-5/
├── Dockerfile                   # Kali image definition
├── docker-compose.yml           # Multi-container orchestration
├── .gitignore                   # Git ignore rules
│
├── config/                      # Shell configurations
│   ├── bashrc                   # Custom bash settings
│   ├── aliases.sh               # Penetration testing aliases
│   └── motd                     # Welcome message
│
├── scripts/                     # Startup scripts
│   ├── start-lab.ps1            # Windows launcher
│   └── start-lab.sh             # Linux/Mac launcher
│
├── workspace/                   # Your coursework (persistent)
│   ├── labs/                    # Lab assignments
│   ├── reports/                 # Lab reports
│   └── notes/                   # Course notes
│
└── wordlists/                   # Custom wordlists (persistent)
```

All files in `workspace/` and `wordlists/` are automatically saved to your host machine.

## 🛠️ Common Commands

Once inside the Kali container, use these shortcuts:

### Navigation
```bash
work            # Go to workspace directory
labs            # Go to labs directory
targets         # Show vulnerable target URLs
```

### Scanning
```bash
quickscan <ip>       # Fast network discovery (nmap -sn)
portscan <ip>        # Full port scan (nmap -p-)
servicescan <ip>     # Service version detection (nmap -sV -sC)
vulnscan <ip>        # Vulnerability scan
```

### Web Testing
```bash
dirbust <url>        # Directory brute-forcing
nikto-scan <url>     # Web server scanner
```

### Tools
```bash
msfconsole           # Start Metasploit Framework (quiet mode)
john-crack <file>    # Crack passwords with John the Ripper
```

Type `alias` inside the container to see all available shortcuts.

## 📦 Installed Tools

The lab includes these Kali metapackages:

- **kali-linux-headless** - Core Kali tools (CLI only)
- **kali-tools-top10** - Most popular penetration testing tools:
  - nmap - Network scanner
  - Metasploit Framework - Exploitation framework
  - Burp Suite Community - Web proxy (CLI tools)
  - John the Ripper - Password cracker
  - Hashcat - Advanced password recovery
  - sqlmap - SQL injection tool
  - Nikto - Web server scanner
  - Gobuster - Directory/DNS brute-forcer
  - And more...

## 🔧 Manual Docker Commands

If you prefer not to use the startup scripts:

**Start Kali with targets (lab mode):**
```bash
docker compose up -d dvwa juice-shop
docker compose run --rm kali /bin/bash
```

**Start Kali with host networking:**
```bash
docker compose run --rm --network host kali /bin/bash
```

**Stop all services:**
```bash
docker compose down
```

**Rebuild image after changes:**
```bash
docker compose build --no-cache
```

## ⚠️ Limitations

Docker-based labs have some limitations compared to full VMs:

| Feature | Docker | Full VM |
|---------|--------|---------|
| Boot time | ✅ Seconds | ⏱️ Minutes |
| Resource usage | ✅ Lightweight | 🐘 Heavy |
| Network scanning | ✅ Supported | ✅ Supported |
| Web app testing | ✅ Supported | ✅ Supported |
| Wireless hacking | ❌ Not supported | ✅ Supported |
| Bluetooth testing | ❌ Not supported | ✅ Supported |
| Kernel exploits | ❌ Not supported | ✅ Supported |
| GUI tools | ❌ CLI only | ✅ Full GUI |
| USB hardware | ❌ Limited | ✅ Full support |

**What works great:**
- Network scanning and enumeration
- Web application penetration testing
- Password cracking (CPU-based)
- Exploitation frameworks (Metasploit)
- Scripting and automation
- Most course assignments

**What requires a VM:**
- Wireless network attacks (requires hardware access)
- Bluetooth hacking
- Kernel exploitation practice
- GUI-intensive workflows

## 🔒 Ethical Use

**Important:** These tools are for educational purposes only. 

- ✅ Use only on authorized targets (lab targets, CTF platforms, your own systems)
- ✅ Complete assignments on the provided vulnerable containers
- ❌ Never attack systems without explicit written permission
- ❌ Do not use these tools for illegal activities

Unauthorized penetration testing is illegal and unethical.

## 🆘 Troubleshooting

### Container won't start
```bash
# Check Docker is running
docker info

# Check for port conflicts
docker ps -a

# Stop conflicting containers
docker compose down
```

### Targets not accessible
```bash
# Verify targets are running
docker ps

# Check network connectivity from Kali
docker exec -it kali-lab ping 172.20.0.2
```

### Permission errors on Linux/Mac
```bash
# Make scripts executable
chmod +x scripts/start-lab.sh
```

### Docker Desktop on Windows (WSL2) networking
If `--network host` doesn't work as expected, you're connecting to WSL2 VM network, not Windows directly. Use bridge mode with port forwarding or run Docker commands from within WSL2.

## 📚 Additional Resources

- [Kali Linux Documentation](https://www.kali.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [Penetration Testing Execution Standard](http://www.pentest-standard.org/)

## 📝 License

This project is for educational purposes as part of NTWK290-5 coursework.

## 🤝 Contributing

To contribute improvements:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

---

**Happy Hacking! 🐉🔓**

*Remember: With great power comes great responsibility. Use these skills ethically.*
