# DevOps Intern - Project Submission

## Objective
Configure secure server access, deploy a containerized web application, and implement firewall rules to control network traffic.

## Project Structure

```
Project-Submission/
├── Task-1/          # Server Setup and SSH Configuration
│   ├── README.md
│   └── Vagrantfile
├── Task-2/          # Docker Installation and Application Deployment
│   ├── README.md
│   ├── Dockerfile
│   └── index.html
├── Task-3/          # Container Resource Monitoring
│   ├── README.md
│   └── monitor.sh
├── Task-4/          # Secure Monitoring Logs (User & Permissions)
│   ├── README.md
│   └── setup-user.sh
├── Task-5/          # Firewall Configuration
│   ├── README.md
│   └── firewall-setup.sh
└── README.md        # This file
```

## Environment
- **Host OS:** Windows
- **VM Provider:** VirtualBox + Vagrant
- **Guest OS:** Ubuntu 22.04 LTS
- **Containerization:** Docker
- **Firewall:** UFW

## How to Use

1. Navigate to `Task-1/` and run `vagrant up` to provision the Linux VM.
2. SSH into the VM using `vagrant ssh` or the configured SSH keys.
3. Follow each task's `README.md` sequentially for setup instructions.

## Video Walkthrough
> A 5-minute walkthrough video demonstrating all tasks is available here:  
> **[Google Drive Link]** *(replace with your actual link)*
