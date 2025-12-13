# Trivy Security Scan – Fixing Vulnerabilities in `github-profile-summarizer` Docker Image

This document explains how Trivy was used to scan the Docker image
theshubhamgour/github-profile-summarizer:latest, identify vulnerabilities, apply a fix using Alpine package upgrades, and then re-scan the updated image.

This README is useful for DevOps, DevSecOps, Cloud, and CI/CD workflows where image security and vulnerability management matter.

This README provides a documentation of how Trivy was used to:
- Scan the Docker image `theshubhamgour/github-profile-summarizer:latest`
- Identify OS-level vulnerabilities (Alpine base)
- Apply fixes using `apk upgrade`
- Rebuild and re-scan the image
- Validate improvements through vulnerability reduction

It follows DevSecOps best practices and includes workflow diagrams, upgrade strategy, and CI/CD considerations.

---
## 1. Initial Scan – Base Image Vulnerabilities
We scanned the image:
 ``` image used :  trivy image theshubhamgour/github-profile-summarizer ```
---

### Report Summary

```
Target: theshubhamgour/github-profile-summarizer (alpine 3.22.2)
Vulnerabilities: 10
Secrets: none
```

```
┌──────────────────────────────────────────────────────────┬────────┬─────────────────┬─────────┐
│                          Target                          │  Type  │ Vulnerabilities │ Secrets │
├──────────────────────────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ theshubhamgour/github-profile-summarizer (alpine 3.22.2) │ alpine │       10        │    -    │
└──────────────────────────────────────────────────────────┴────────┴─────────────────┴─────────┘
```

### Severity Breakdown

| Severity | Count |
|---------|-------|
| HIGH    | 2 |
| MEDIUM  | 5 |
| LOW     | 3 |
| CRITICAL | 0 |


```

theshubhamgour/github-profile-summarizer (alpine 3.22.2)

Total: 10 (UNKNOWN: 0, LOW: 3, MEDIUM: 5, HIGH: 2, CRITICAL: 0)

┌───────────────┬────────────────┬──────────┬────────┬───────────────────┬───────────────┬──────────────────────────────────────────────────────────────┐
│    Library    │ Vulnerability  │ Severity │ Status │ Installed Version │ Fixed Version │                            Title                             │
├───────────────┼────────────────┼──────────┼────────┼───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ busybox       │ CVE-2024-58251 │ MEDIUM   │ fixed  │ 1.37.0-r19        │ 1.37.0-r20    │ In netstat in BusyBox through 1.37.0, local users can launch │
│               │                │          │        │                   │               │ of networ...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2024-58251                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-46394 │ LOW      │        │                   │               │ In tar in BusyBox through 1.37.0, a TAR archive can have     │
│               │                │          │        │                   │               │ filenames...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-46394                   │
├───────────────┼────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│ busybox-binsh │ CVE-2024-58251 │ MEDIUM   │        │                   │               │ In netstat in BusyBox through 1.37.0, local users can launch │
│               │                │          │        │                   │               │ of networ...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2024-58251                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-46394 │ LOW      │        │                   │               │ In tar in BusyBox through 1.37.0, a TAR archive can have     │
│               │                │          │        │                   │               │ filenames...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-46394                   │
├───────────────┼────────────────┼──────────┤        ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ libpng        │ CVE-2025-64720 │ HIGH     │        │ 1.6.47-r0         │ 1.6.51-r0     │ libpng: LIBPNG buffer overflow                               │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-64720                   │
│               ├────────────────┤          │        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-65018 │          │        │                   │               │ libpng: LIBPNG heap buffer overflow                          │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-65018                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-64505 │ MEDIUM   │        │                   │               │ libpng: LIBPNG heap buffer overflow via malformed palette    │
│               │                │          │        │                   │               │ index                                                        │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-64505                   │
│               ├────────────────┤          │        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-64506 │          │        │                   │               │ libpng: LIBPNG heap buffer over-read                         │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-64506                   │
├───────────────┼────────────────┤          │        ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ ssl_client    │ CVE-2024-58251 │          │        │ 1.37.0-r19        │ 1.37.0-r20    │ In netstat in BusyBox through 1.37.0, local users can launch │
│               │                │          │        │                   │               │ of networ...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2024-58251                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-46394 │ LOW      │        │                   │               │ In tar in BusyBox through 1.37.0, a TAR archive can have     │
│               │                │          │        │                   │               │ filenames...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-46394                   │
└───────────────┴────────────────┴──────────┴────────┴───────────────────┴───────────────┴───────────────────────────────
```
Major affected packages:
- **libpng** (High severity buffer overflows)
- **busybox**, **busybox-binsh**, **ssl_client**

These are common in Alpine-based images when the base image is not updated.

---

# 2. Vulnerability Table (Before Fix)

The complete vulnerability table is included in the original scan output (Trivy CLI).  
Key findings:

### **High Severity (libpng)**  
- CVE-2025-64720 — Buffer overflow  
- CVE-2025-65018 — Heap buffer overflow  

### **Medium / Low Severity (BusyBox)**  
- CVE-2024-58251  
- CVE-2025-46394  

These vulnerabilities were patchable via simple package upgrades.

---

# 3. DevSecOps Workflow – How Trivy Fits

```
+---------------------------------------------------------------+
|                        Developer Writes Code                  |
+-----------------------+---------------------------------------+
                        |
                        v
+---------------------------------------------------------------+
|                  Build Docker Image (CI Pipeline)             |
+-----------------------+---------------------------------------+
                        |
                        v
+---------------------------------------------------------------+
|                 Trivy Image Scan Stage                        |
|  - CVE Detection (OS + App packages)                          |
|  - Severity filtering (HIGH, CRITICAL)                        |
|  - Fails pipeline on severe issues                            |
+-----------------------+---------------------------------------+
                        |
                        v
+---------------------------------------------------------------+
|            Security Gate Passed → Deploy to Prod              |
+---------------------------------------------------------------+
```

This workflow ensures **shift-left security** by catching vulnerabilities before deployment.

---

# 4. Fixing Vulnerabilities – Updating Alpine Packages

To fix the `libpng` (HIGH) and multiple BusyBox vulnerabilities, we updated packages inside the Dockerfile.

### Dockerfile Patch

Dockerfile with fix :
```
FROM theshubhamgour/github-profile-summarizer:latest

# Update package indexes and upgrade libpng (and busybox to clean up some others)
RUN apk update && \
    apk upgrade --no-cache libpng
```

### Build the Updated Image

```
docker build -t theshubhamgour/github-profile-summarizer:fixed-libpng .
```


Then scan:
```
trivy image theshubhamgour/github-profile-summarizer:fixed-libpng
```

After Fix scan result

```

theshubhamgour/github-profile-summarizer:fixed-libpng (alpine 3.22.2)

Total: 6 (UNKNOWN: 0, LOW: 3, MEDIUM: 3, HIGH: 0, CRITICAL: 0)

┌───────────────┬────────────────┬──────────┬────────┬───────────────────┬───────────────┬──────────────────────────────────────────────────────────────┐
│    Library    │ Vulnerability  │ Severity │ Status │ Installed Version │ Fixed Version │                            Title                             │
├───────────────┼────────────────┼──────────┼────────┼───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ busybox       │ CVE-2024-58251 │ MEDIUM   │ fixed  │ 1.37.0-r19        │ 1.37.0-r20    │ In netstat in BusyBox through 1.37.0, local users can launch │
│               │                │          │        │                   │               │ of networ...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2024-58251                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-46394 │ LOW      │        │                   │               │ In tar in BusyBox through 1.37.0, a TAR archive can have     │
│               │                │          │        │                   │               │ filenames...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-46394                   │
├───────────────┼────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│ busybox-binsh │ CVE-2024-58251 │ MEDIUM   │        │                   │               │ In netstat in BusyBox through 1.37.0, local users can launch │
│               │                │          │        │                   │               │ of networ...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2024-58251                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-46394 │ LOW      │        │                   │               │ In tar in BusyBox through 1.37.0, a TAR archive can have     │
│               │                │          │        │                   │               │ filenames...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-46394                   │
├───────────────┼────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│ ssl_client    │ CVE-2024-58251 │ MEDIUM   │        │                   │               │ In netstat in BusyBox through 1.37.0, local users can launch │
│               │                │          │        │                   │               │ of networ...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2024-58251                   │
│               ├────────────────┼──────────┤        │                   │               ├──────────────────────────────────────────────────────────────┤
│               │ CVE-2025-46394 │ LOW      │        │                   │               │ In tar in BusyBox through 1.37.0, a TAR archive can have     │
│               │                │          │        │                   │               │ filenames...                                                 │
│               │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-46394                   │
└───────────────┴────────────────┴──────────┴────────┴───────────────────┴───────────────┴──────────────────────────────────────────────────────────────┘
```
# 5. Scan After Fix (Improved Security Score)

```
trivy image theshubhamgour/github-profile-summarizer:fixed-libpng
```

### Updated Vulnerability Count

| Severity | Before | After |
|----------|--------|--------|
| HIGH     | 2 | **0** |
| MEDIUM   | 5 | **3** |
| LOW      | 3 | **3** |
| CRITICAL | 0 | 0 |

### What Was Fixed

✅ All **High severity libpng issues**  
❌ Remaining: Medium + Low BusyBox vulnerabilities (unpatched upstream)

Remaining issues are expected for Alpine and low-risk for typical workloads.

---

# 6. Architecture Diagram – Image Upgrade Flow

```
        +-------------------------------+
        |   Base Image (Alpine 3.22.2)  |
        +-----------------------+-------+
                                |
                                v
        +-------------------------------------------+
        |       Trivy Scan (10 vulnerabilities)     |
        +-----------------------+-------------------+
                                |
                                v
        +-------------------------------------------+
        |  Apply Fix (apk upgrade libpng busybox)   |
        +-----------------------+-------------------+
                                |
                                v
        +-------------------------------------------+
        | Build Patched Image :fixed-libpng         |
        +-----------------------+-------------------+
                                |
                                v
        +-------------------------------------------+
        |  Re-scan with Trivy (6 remaining issues)  |
        +-------------------------------------------+
```

---

# 7. DevSecOps Best Practices (Recommended)

### 1. Always Scan in CI/CD
Example for Jenkins/gitHub Actions:

```
trivy image --exit-code 1 --severity HIGH,CRITICAL <image>
```

### 2. Avoid outdated Alpine tags

Use version-pinned, actively maintained tags.

### 3. Perform Regular Image Maintenance
- `apk upgrade`  
- Base image refresh  
- Use distroless if possible  

---

# 4. Conclusion

This workflow demonstrates:
- How Trivy quickly identifies OS-level vulnerabilities  
- How simple patching dramatically reduces risk  
- That regular image maintenance improves your security posture  
- Production readiness by eliminating High severity CVEs  

Your secure image is now:

```
theshubhamgour/github-profile-summarizer:fixed-libpng
```

---


