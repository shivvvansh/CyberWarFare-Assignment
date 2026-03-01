# Task 2: Docker Installation and Application Deployment

## Objective
Install Docker on the server, create a Dockerfile to host a custom `index.html` page, build the image, run the container, and expose it on port 8000.

---

## Step 1: Install Docker on the Server

SSH into the VM first:
```bash
ssh devops-server
# or: vagrant ssh (from Task-1 directory)
```

Install Docker:
```bash
# Update package index
sudo apt-get update -y

# Install prerequisite packages
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add current user to docker group (avoid using sudo for docker commands)
sudo usermod -aG docker $USER

# Apply group changes (or log out and back in)
newgrp docker
```

---

## Step 2: Verify Docker Installation

```bash
# Check Docker version
docker --version

# Verify Docker is running
sudo systemctl status docker

# Test with hello-world
docker run hello-world
```

**Expected output:** Docker version info and "Hello from Docker!" message.

---

## Step 3: Copy Project Files to the Server

From your host machine, copy the Dockerfile and index.html to the VM:
```bash


Alternatively, create the files directly on the server:
```bash
mkdir -p ~/app
cd ~/app
```

---

## Step 4: Build the Docker Image

```bash
cd ~/app

# Build the Docker image
docker build -t my-web-app .
```

**Expected output:**
```
Successfully built <image_id>
Successfully tagged my-web-app:latest
```

---

## Step 5: Run the Docker Container

```bash
# Run the container, mapping host port 8000 to container port 80
docker run -d --name web-container -p 8000:80 my-web-app
```

---

## Step 6: Verify the Deployment

```bash
# Check running containers
docker ps

# Test locally from the server
curl http://localhost:8000
```

From your **host machine's browser**, navigate to:
```
http://192.168.56.10:8000
```
or (if port forwarding is active):
```
http://localhost:8000
```

---

## Step 7: Useful Docker Commands

```bash
# View container logs
docker logs web-container

# Stop the container
docker stop web-container

# Start the container
docker start web-container

# Remove the container
docker rm -f web-container

# List all images
docker images
```

---

## Expected Outcome
The web application is accessible through a browser using the server IP address and port `8000`, displaying the custom HTML page.

---

## Files
- `Dockerfile` — Container build instructions (Nginx + custom HTML)
- `index.html` — Custom web page served by the container
