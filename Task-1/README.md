# Task 1: Server Setup and SSH Configuration

## Objective
Provision a Linux server (local virtual machine) and configure secure SSH connectivity with passwordless key-based authentication.

---

## Prerequisites
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads) installed

---

## Step 1: Provision the Linux Server

```bash
# Navigate to the Task-1 directory
cd Project-Submission/Task-1/

# Start and provision the VM
vagrant up
```

This uses the included `Vagrantfile` which:
- Creates an Ubuntu 22.04 LTS VM
- Assigns a private IP: `192.168.56.10`
- Forwards port 8000 (used later for Docker)
- Installs and configures OpenSSH server
- Disables password authentication

---

## Step 2: Verify SSH Access via Vagrant

```bash
# SSH into the VM (uses Vagrant's default key)
vagrant ssh
```
exit if 
---

## Step 3: Generate SSH Key Pair (on Host Machine)

```bash
# Generate an SSH key pair (run on your host machine)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/devops_server_key -C "devops-intern"
```

When prompted for a passphrase, press Enter for no passphrase (or set one for extra security).

---

## Step 4: Copy Public Key to the VM

```bash
# Copy the public key to the VM
cat ~/.ssh/devops_server_key.pub | vagrant ssh -c "cat >> ~/.ssh/authorized_keys"
```

---

## Step 5: Test Passwordless SSH Login

```bash
# SSH into the VM using the private key (no password required)
ssh -i ~/.ssh/devops_server_key vagrant@127.0.0.1 -p 2222
```

---

## Step 6: (Optional) Configure SSH Config File

Add the following to `~/.ssh/config` on your host machine for easier access:

```
Host devops-server
    HostName 127.0.0.1
    Port 2222
    User vagrant
    IdentityFile ~/.ssh/devops_server_key
    StrictHostKeyChecking no
```

Then connect simply with:
```bash
ssh devops-server
```

---

## Step 7: Verify Password Authentication is Disabled (Inside VM)

```bash
# Inside the VM, verify SSH config
sudo grep -E "PasswordAuthentication|PubkeyAuthentication" /etc/ssh/sshd_config
```

**Expected output:**
```
PubkeyAuthentication yes
PasswordAuthentication no
```

---

## SSH Configuration Changes Made

| Setting | Value | Purpose |
|---------|-------|---------|
| `PubkeyAuthentication` | `yes` | Enable key-based login |
| `PasswordAuthentication` | `no` | Disable password login |
| `ChallengeResponseAuthentication` | `no` | Disable challenge-response |

---

## Expected Outcome
Secure remote access to the server using SSH keys without password authentication.

---

## Files
- `Vagrantfile` — VM provisioning configuration
