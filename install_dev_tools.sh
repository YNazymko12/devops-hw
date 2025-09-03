#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update -y
echo "Package list updated."

# ---

## Install Docker
echo "Checking for Docker installation..."
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Starting installation..."
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker installed."
    
    # Add the current user to the docker group
    sudo usermod -aG docker $USER
    echo "User $USER has been added to the docker group. You need to log out and log back in for the changes to take effect."
else
    echo "Docker is already installed."
fi

# ---

## Install Docker Compose
echo "Checking for Docker Compose installation..."
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose not found. Starting installation..."
    # We will use the docker-compose-plugin that is installed with Docker
    echo "Docker Compose will be used as a plugin (docker compose)."
else
    echo "Docker Compose is already installed."
fi

# ---

## Install Python
echo "Checking for Python 3.9+ installation..."
# Check Python version
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    if [[ $(echo "$PYTHON_VERSION" | tr -d '.') -ge 39 ]]; then
        echo "Python $PYTHON_VERSION is already installed."
    else
        echo "Installed Python version is $PYTHON_VERSION. 3.9 or newer is required."
        sudo apt-get install -y python3.9 python3.9-venv
        echo "Python 3.9 installed."
    fi
else
    echo "Python not found. Starting Python 3.9 installation..."
    sudo apt-get install -y python3.9 python3.9-venv
    echo "Python 3.9 installed."
fi

# ---

## Install Django
echo "Checking for Django installation..."
if ! python3 -c "import django" &> /dev/null; then
    echo "Django not found. Starting installation..."
    pip install django
    echo "Django installed."
else
    echo "Django is already installed."
fi

echo "All tools installed."
