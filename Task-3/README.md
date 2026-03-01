# Task 3: Monitor Container Resource Usage

## Objective
Create a monitoring script to capture container CPU and memory usage with timestamps, store logs in a dedicated directory, and automate the process using a cron job that runs every minute.

---

## Step 1: Create the Monitoring Directory

```bash
# Create the log storage directory
sudo mkdir -p /opt/container-monitor/logs
```

---

## Step 2: Copy the Monitoring Script to the Server

```bash
# Copy the monitoring script
sudo cp monitor.sh /opt/container-monitor/monitor.sh

# Make it executable
sudo chmod +x /opt/container-monitor/monitor.sh
```

---

## Step 3: Understand the Monitoring Script

The `monitor.sh` script does the following:
1. Checks if the target container (`web-container`) is running
2. Uses `docker stats --no-stream` to capture a snapshot of:
   - **CPU usage** (percentage)
   - **Memory usage** (used / limit and percentage)
3. Prepends a **timestamp** to each log entry
4. Appends the log entry to a daily log file at `/opt/container-monitor/logs/`

### Sample log output:
```
[2026-03-01 14:30:01] Container: web-container | CPU: 0.05% | Memory: 3.5MiB / 1.94GiB (0.18%)
[2026-03-01 14:31:01] Container: web-container | CPU: 0.03% | Memory: 3.5MiB / 1.94GiB (0.18%)
```

---

## Step 4: Test the Script Manually

```bash
# Run the script once to test
sudo /opt/container-monitor/monitor.sh

# Check the log output
cat /opt/container-monitor/logs/container-monitor-$(date +%Y-%m-%d).log
```

---

## Step 5: Automate with Cron Job (Runs Every Minute)

```bash
# Open root's crontab
sudo crontab -e
```

Add the following line at the end:
```
* * * * * /opt/container-monitor/monitor.sh
```

Save and exit.

---

## Step 6: Verify Cron Job

```bash
# List the cron jobs for root
sudo crontab -l
```

**Expected output:**
```
* * * * * /opt/container-monitor/monitor.sh
```

Wait 2-3 minutes, then check the logs:
```bash
cat /opt/container-monitor/logs/container-monitor-$(date +%Y-%m-%d).log
```

You should see entries being added every minute with timestamps.

---

## Step 7: View Real-Time Logs

```bash
# Watch the log file in real-time
tail -f /opt/container-monitor/logs/container-monitor-$(date +%Y-%m-%d).log
```

---

## Expected Outcome
- Automatic container resource monitoring running every minute via cron
- Log files stored in `/opt/container-monitor/logs/` with daily rotation
- Each entry includes timestamp, CPU usage, and memory usage

---

## Files
- `monitor.sh` — Shell script that captures container CPU & memory usage with timestamps
