# Task 5: Firewall Configuration

## Objective
Install and configure UFW (Uncomplicated Firewall) to restrict unauthorized access while allowing SSH (from a specific IP), HTTP, and port 8000.

---

## Step 1: Install UFW

```bash
sudo apt-get update -y
sudo apt-get install -y ufw
```

---

## Step 2: Check UFW Status

```bash
sudo ufw status
```
Output: `Status: inactive` (initially)

---

## Step 3: Set Default Policies

```bash
# Deny all incoming traffic by default
sudo ufw default deny incoming

# Allow all outgoing traffic by default
sudo ufw default allow outgoing
```

---

## Step 4: Allow SSH Access from a Specific IP Only

```bash
# Replace 192.168.56.1 with your actual host/admin IP
sudo ufw allow from 192.168.56.1 to any port 22 proto tcp
```

> **Note:** `192.168.56.1` is the default VirtualBox host IP on the private network. Replace it with
> your actual admin machine IP if different.

---

## Step 5: Allow HTTP Access (Port 80)

```bash
sudo ufw allow 80/tcp
```

---

## Step 6: Allow Traffic on Port 8000 (Docker App)

```bash
sudo ufw allow 8000/tcp
```

---

## Step 7: Enable UFW

```bash
sudo ufw enable
```

When prompted, type `y` to confirm.

---

## Step 8: Verify Firewall Configuration

```bash
# Check status with details
sudo ufw status verbose
```

**Expected output:**
```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    192.168.56.1
80/tcp                     ALLOW IN    Anywhere
8000/tcp                   ALLOW IN    Anywhere
80/tcp (v6)                ALLOW IN    Anywhere (v6)
8000/tcp (v6)              ALLOW IN    Anywhere (v6)
```

Numbered list view:
```bash
sudo ufw status numbered
```

---

## Step 9: Test Firewall Rules

### Test SSH access (from allowed IP):
```bash
# From your host machine (192.168.56.1)
ssh -i ~/.ssh/devops_server_key vagrant@192.168.56.10
# Should succeed ✅
```

### Test HTTP access:
```bash
curl http://192.168.56.10
# Should succeed ✅
```

### Test port 8000 access:
```bash
curl http://192.168.56.10:8000
# Should succeed ✅ (Docker container page)
```

### Test SSH from a different IP (should be blocked):
```bash
# From a different machine or IP
ssh vagrant@192.168.56.10
# Should be denied/timeout ❌
```

---

## Firewall Rules Summary

| Rule | Port | Protocol | Source | Action |
|------|------|----------|--------|--------|
| SSH  | 22   | TCP      | 192.168.56.1 (specific IP) | ALLOW |
| HTTP | 80   | TCP      | Anywhere | ALLOW |
| Docker App | 8000 | TCP | Anywhere | ALLOW |
| All other incoming | * | * | Anywhere | DENY |
| All outgoing | * | * | Anywhere | ALLOW |

---

## Useful UFW Commands

```bash
# Disable firewall
sudo ufw disable

# Delete a specific rule by number
sudo ufw delete <rule_number>

# Reset all rules
sudo ufw reset

# Check app profiles
sudo ufw app list
```

---

## Automated Setup

Run the provided script to configure all firewall rules automatically:
```bash
# Edit the ADMIN_IP variable in the script first if needed
sudo bash firewall-setup.sh
```

---

## Expected Outcome
A secure firewall configuration that:
- Restricts SSH access to a specific admin IP only
- Allows HTTP traffic (port 80)
- Allows Docker application traffic (port 8000)
- Denies all other unauthorized incoming traffic

---

## Files
- `firewall-setup.sh` — Automated UFW firewall configuration script
