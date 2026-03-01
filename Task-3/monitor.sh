#!/bin/bash
# ============================================================
# Container Resource Monitoring Script
# Monitors CPU and memory usage of Docker containers
# Logs output with timestamps to /opt/container-monitor/logs/
# ============================================================

# Configuration
LOG_DIR="/opt/container-monitor/logs"
LOG_FILE="${LOG_DIR}/container-monitor-$(date +%Y-%m-%d).log"
CONTAINER_NAME="web-container"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Get timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Check if the container is running
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    # Get container stats (CPU% and Memory usage)
    STATS=$(docker stats "$CONTAINER_NAME" --no-stream --format "CPU: {{.CPUPerc}} | Memory: {{.MemUsage}} ({{.MemPerc}})")

    # Log the data with timestamp
    echo "[$TIMESTAMP] Container: $CONTAINER_NAME | $STATS" >> "$LOG_FILE"
else
    echo "[$TIMESTAMP] Container: $CONTAINER_NAME | Status: NOT RUNNING" >> "$LOG_FILE"
fi
