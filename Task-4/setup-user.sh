#!/bin/bash
# ============================================================
# Setup Dedicated Monitoring User and Permissions
# Creates a monitoring user and restricts log access
# ============================================================

set -e

MONITOR_USER="monitor-user"
MONITOR_DIR="/opt/container-monitor"

echo "=== Setting up dedicated monitoring user ==="

# Step 1: Create the dedicated monitoring user (no login shell for security)
if id "$MONITOR_USER" &>/dev/null; then
    echo "User '$MONITOR_USER' already exists. Skipping creation."
else
    sudo useradd -r -s /bin/bash -m "$MONITOR_USER"
    echo "✅ User '$MONITOR_USER' created."
fi

# Step 2: Ensure monitoring directory exists
sudo mkdir -p "$MONITOR_DIR/logs"
echo "✅ Directory '$MONITOR_DIR' ensured."

# Step 3: Assign ownership of monitoring folder to the monitoring user
sudo chown -R "$MONITOR_USER":"$MONITOR_USER" "$MONITOR_DIR"
echo "✅ Ownership of '$MONITOR_DIR' assigned to '$MONITOR_USER'."

# Step 4: Set permissions — full access for owner, no access for others
sudo chmod -R 700 "$MONITOR_DIR"
echo "✅ Permissions set: owner=rwx, group=---, others=---"

# Step 5: Add monitor-user to docker group (needed to run docker stats)
sudo usermod -aG docker "$MONITOR_USER"
echo "✅ '$MONITOR_USER' added to docker group."

# Step 6: Update cron job to run as monitor-user
# Remove from root crontab and add to monitor-user's crontab
(sudo crontab -u "$MONITOR_USER" -l 2>/dev/null; echo "* * * * * $MONITOR_DIR/monitor.sh") | sort -u | sudo crontab -u "$MONITOR_USER" -

echo "✅ Cron job set for '$MONITOR_USER'."

echo ""
echo "=== Setup Complete ==="
echo "Monitoring user: $MONITOR_USER"
echo "Monitoring directory: $MONITOR_DIR"
echo ""
echo "Run the verification commands from the README to confirm access control."
