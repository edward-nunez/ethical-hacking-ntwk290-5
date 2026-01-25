FROM kalilinux/kali-rolling

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential metapackages
RUN apt update && apt -y upgrade && \
    apt -y install kali-linux-headless && \
    apt -y install kali-tools-top10 && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Install additional useful CLI tools
RUN apt update && apt -y install \
    vim \
    nano \
    tmux \
    git \
    curl \
    wget \
    net-tools \
    iputils-ping \
    man-db \
    tree \
    zip \
    unzip \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /root/workspace

# Copy custom configurations
COPY config/bashrc /root/.bashrc
COPY config/aliases.sh /root/.aliases
COPY config/motd /etc/motd

# Display MOTD on login
RUN echo 'cat /etc/motd' >> /root/.bashrc

# Default command
CMD ["/bin/bash"]
