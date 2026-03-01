#!/bin/bash
# ============================================================
# UFW Firewall Configuration Script
# Configures firewall rules for the DevOps server
# ============================================================

set -e

# ---- CONFIGURATION ----
# Replace this with your actual host/admin IP address
ADMIN_IP="192.168.56.1"

echo "=== Configuring UFW Firewall ==="

# Step 1: Install UFW (if not already installed)
sudo apt-get update -y
sudo apt-get install -y ufw

# Step 2: Reset UFW to defaults (clean state)
echo "y" | sudo ufw reset

# Step 3: Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing
echo "✅ Default policies set: deny incoming, allow outgoing"

# Step 4: Allow SSH (port 22) only from the specific admin IP
sudo ufw allow from "$ADMIN_IP" to any port 22 proto tcp comment "SSH from admin IP"
echo "✅ SSH (port 22) allowed from $ADMIN_IP only"

# Step 5: Allow HTTP (port 80) from anywhere
sudo ufw allow 80/tcp comment "HTTP access"
echo "✅ HTTP (port 80) allowed"

# Step 6: Allow traffic on port 8000 (Docker container)
sudo ufw allow 8000/tcp comment "Docker app on port 8000"
echo "✅ Port 8000 allowed (Docker application)"

# Step 7: Enable UFW
echo "y" | sudo ufw enable
echo "✅ UFW firewall enabled"

# Step 8: Display current rules
echo ""
echo "=== Current Firewall Rules ==="
sudo ufw status verbose
sudo ufw status numbered

echo ""
echo "=== Firewall Configuration Complete ==="
