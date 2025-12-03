# Trivy Installation on AWS EC2 (Ubuntu)

This guide explains **what Trivy is**, **why it's used**, and how to **install it on an AWS EC2 Ubuntu instance**.  
All commands are explained clearly for beginners.

---

## 📌 What is Trivy?

**Trivy** is an open‑source **security scanner** used in DevSecOps pipelines.  
It scans:

- Docker images  
- File systems  
- Git repositories  
- Kubernetes clusters  
- SBOMs (Software Bill of Materials)

Trivy detects:
- **Vulnerabilities (CVEs)**
- **Misconfigurations**
- **Secrets in code**
- **License issues**

It's lightweight, fast, and widely used in CI/CD security workflows.

---

## 📌 Why Use Trivy?

- Helps you secure container images before deployment  
- Detects high‑risk vulnerabilities early  
- Integrates easily with GitHub Actions, Jenkins, GitLab, Azure DevOps  
- Essential for DevSecOps and cloud security practices  

---

## 📌 Install Trivy on AWS EC2 (Ubuntu)

Run the following commands one by one:

```bash
sudo apt-get install wget gnupg
```
✔ Installs **wget** (used to download files) and **gnupg** (used for key verification).

---

```bash
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
```
✔ Downloads Aqua Security's **public GPG key**  
✔ Converts it to `.gpg` format  
✔ Saves it in `/usr/share/keyrings` so apt can trust the repository

---

```bash
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
```
✔ Adds the official **Trivy apt repository** to your system  
✔ Ensures all packages from it are verified using `trivy.gpg`

---

```bash
sudo apt-get update
```
✔ Refreshes the system package index  
✔ Allows apt to detect the newly added Trivy repository

---

```bash
sudo apt-get install trivy
```
✔ Installs Trivy  
✔ You can confirm installation with:

```bash
trivy --version
```

---

## 🎉 You're Ready to Use Trivy!

Example scan a Docker image:

```bash
trivy image nginx:latest
```

---

## Author
Prepared for AWS DevOps + Trivy beginners.

