# Penetration Testing Aliases

# Navigation shortcuts
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Directory shortcuts
alias work='cd /root/workspace'
alias labs='cd /root/workspace/labs'
alias wordlists='cd /usr/share/wordlists'

# Network scanning
alias quickscan='nmap -sn'
alias portscan='nmap -p-'
alias servicescan='nmap -sV -sC'
alias vulnscan='nmap --script vuln'

# Web application testing
alias dirbust='gobuster dir -w /usr/share/wordlists/dirb/common.txt -u'
alias nikto-scan='nikto -h'

# Information gathering
alias whois-lookup='whois'
alias dns-enum='dnsrecon -d'
alias subdomain-enum='sublist3r -d'

# Exploitation
alias msfconsole='msfconsole -q'
alias msf='msfconsole -q'

# Password cracking
alias john-crack='john --wordlist=/usr/share/wordlists/rockyou.txt'
alias hashcat-crack='hashcat -m 0 -a 0'

# Utilities
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'
alias listening='netstat -tulanp | grep LISTEN'
alias update-kali='apt update && apt upgrade -y'

# Docker/Lab targets
alias target-dvwa='echo "DVWA: http://172.20.0.2:80 or http://localhost:8080"'
alias target-juice='echo "Juice Shop: http://172.20.0.3:3000 or http://localhost:3000"'
alias targets='echo "DVWA: http://localhost:8080" && echo "Juice Shop: http://localhost:3000"'

# History
alias h='history'
alias hgrep='history | grep'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
