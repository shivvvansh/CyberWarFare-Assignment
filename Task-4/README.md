# Task 4: Secure Monitoring Logs by Restricting Access

## Objective
Create a dedicated user for monitoring operations and restrict access to the monitoring logs so that only the designated user can read/write them.

---

## Step 1: Create a Dedicated Monitoring User

```bash
# Create a system user for monitoring (with bash shell)
sudo useradd -r -s /bin/bash -m monitor-user
```

---

## Step 2: Create Monitoring Directory

```bash
# Ensure the monitoring directory exists
sudo mkdir -p /opt/container-monitor/logs
```

---

## Step 3: Assign Ownership to the Monitoring User

```bash
# Change ownership of the entire monitoring folder to monitor-user
sudo chown -R monitor-user:monitor-user /opt/container-monitor
```

---

## Step 4: Set Permissions (Full Access to Owner, Restrict Others)

```bash
# Give full access (rwx) to the owner, no access to group and others
sudo chmod -R 700 /opt/container-monitor
```

### Permission Breakdown

| Permission | Owner (monitor-user) | Group | Others |
|------------|---------------------|-------|--------|
| Read       | ✅                  | ❌    | ❌     |
| Write      | ✅                  | ❌    | ❌     |
| Execute    | ✅                  | ❌    | ❌     |

---

## Step 5: Add Monitoring User to Docker Group

The monitoring user needs access to Docker to run `docker stats`:
```bash
sudo usermod -aG docker monitor-user
```

---

## Step 6: Move Cron Job to Monitoring User

```bash
# Remove cron from root (if previously set in Task 3)
sudo crontab -e
# (Remove the monitor.sh line and save)

# Add cron job under monitor-user
sudo crontab -u monitor-user -e
```

Add this line:
```
* * * * * /opt/container-monitor/monitor.sh
```

---

## Step 7: Verify Access Control

### Test as monitor-user (should succeed):
```bash
sudo -u monitor-user ls -la /opt/container-monitor/
sudo -u monitor-user cat /opt/container-monitor/logs/container-monitor-$(date +%Y-%m-%d).log
```

### Test as a regular user (should be denied):
```bash
# Try accessing as vagrant or another user (should fail)
ls /opt/container-monitor/logs/
cat /opt/container-monitor/logs/container-monitor-$(date +%Y-%m-%d).log
```

**Expected output for unauthorized user:**
```
ls: cannot open directory '/opt/container-monitor/logs/': Permission denied
cat: /opt/container-monitor/logs/...: Permission denied
```

### Verify ownership and permissions:
```bash
ls -la /opt/container-monitor/
ls -la /opt/container-monitor/logs/
```

**Expected output:**
```
drwx------ monitor-user monitor-user ... /opt/container-monitor/
drwx------ monitor-user monitor-user ... /opt/container-monitor/logs/
```

---

## Automated Setup

You can also run the provided setup script to perform all steps automatically:
```bash
sudo bash setup-user.sh
```

---

## Expected Outcome
- A dedicated `monitor-user` owns the monitoring directory
- Only `monitor-user` has access to `/opt/container-monitor/` and its logs
- Other users are denied access (permission denied)
- Cron job runs under `monitor-user`

---

## Files
- `setup-user.sh` — Automated script to create user and configure permissions
