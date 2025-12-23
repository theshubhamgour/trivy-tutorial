# Trivy HTML Vulnerability Report Demo

Till now, we’ve been reading **Trivy output in the terminal**.  
But in real-world projects, **security teams need reports** — something **shareable, readable, and professional**.

In this demo, you’ll learn how to generate a **clean HTML vulnerability report** for the Docker image:

```
python:3.10-slim
```

using **Trivy**.

---

## 🧩 Step 1: Download the HTML Template

Trivy supports **custom output formats** using templates.  
Aqua Security already provides an **official HTML template**, so we’ll use that.

### Command

```bash
curl -o html.tpl https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl
```

### In simple terms

- This file controls **how the report looks**
- It converts **raw scan data** into a **web-style HTML page**
- No need to write HTML from scratch

---

## 🐳 Step 2: Scan the Image & Generate HTML Report

Now let’s scan the image and directly save the output as an HTML file.

### Command

```bash
trivy image   --format template   --template "@html.tpl"   -o trivy-report.html   python:3.10-slim
```

### Line-by-line explanation

- `trivy image` → Scan a Docker image  
- `--format template` → Tell Trivy to use a template-based output  
- `--template "@html.tpl"` → Use the downloaded HTML layout  
- `-o trivy-report.html` → Save output to a file  
- `python:3.10-slim` → Image being scanned  

---

## 🌐 Step 3: Open the HTML Report

After the scan finishes, you’ll see a new file.

```bash
ls trivy-report.html
```

### Open the report

**macOS**
```bash
open trivy-report.html
```

**Linux**
```bash
xdg-open trivy-report.html
```

**Windows (PowerShell)**
```powershell
start trivy-report.html
```

✅ This opens a **full web-style security report** in your browser.

---

## 📊 Step 4: Understanding the HTML Report

Inside the report, you’ll see:

- Image name: `python:3.10-slim`
- OS detected (Debian slim)
- Vulnerability summary by severity
- Detailed tables showing:
  - Package name
  - CVE ID
  - Severity
  - Installed version
  - Fixed version
  - Description

### Layman explanation

This is the **same data you saw in the terminal**,  
but now it’s **readable, shareable, and audit-friendly**.

---

## 🧠 Real-World Usage (Important)

In real DevSecOps teams, this HTML report is:

- Attached to **Jira tickets**
- Shared with **security teams**
- Uploaded as **CI/CD pipeline artifacts**
- Used for **compliance and audits**

👉 This is why **report generation is critical**, not optional.

---

## 🔐 Bonus: Show Only HIGH & CRITICAL Vulnerabilities

To reduce noise and focus only on serious risks:

```bash
trivy image   --severity HIGH,CRITICAL   --format template   --template "@html.tpl"   -o trivy-report-high.html   python:3.10-slim
```

### Why this helps

- Removes low/medium noise  
- Helps teams focus on **real production risks**

---

## ✅ Mini Recap

In this demo, you learned how to:

- Download Trivy’s official HTML template
- Scan a Docker image
- Generate a professional HTML vulnerability report
- Open and understand the report
- Use reports the same way **real DevSecOps teams do**

---

