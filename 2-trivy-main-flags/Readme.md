
# Trivy Flags Explained — Full Guide with Commands & Sample Output

Using trivy is easy but controlling *what* Trivy shows, *which vulnerabilities* matter, and *when* it should fail your CI/CD pipeline is where the real skill begins.

This guide explains the **3 most important Trivy flags** every beginner must understand.


By default, Trivy shows all vulnerabilities:  
`LOW`, `MEDIUM`, `HIGH`, `CRITICAL`.

If you only care about important issues:

## 1. --severity (Filter by Importance)
Filters vulnerabilities based on severity levels.


### Example:
```
trivy image --severity HIGH,CRITICAL python:3.10
```

### Sample Output:
```
Total: 12 (HIGH: 8, CRITICAL: 4)

CRITICAL: CVE-2023-12345
Package: openssl
Installed: 1.1.1-1
Fixed: 1.1.1-2

HIGH: CVE-2022-54321
Package: libc6
Installed: 2.31
Fixed: 2.32
```
Benefits:
- Reduces noise  
- Highlights serious issues  
- Helps in quick security reviews 
---

## 2. --vuln-type (Choose OS or Library Vulnerabilities)

### OS-only vulnerabilities:
```
trivy image --vuln-type os python:3.10
```

### Library-only vulnerabilities:
```
trivy image --vuln-type library python:3.10
```

### Sample Output (library only):
```
CVE-2023-67890 (CRITICAL)
Package: requests (Python)
Installed: 2.25.0
Fixed: 2.31.0
```

---

## 3. --exit-code (Fail CI/CD Pipeline on Vulnerabilities)

By default, Trivy exits with code **0** (success) even if it finds vulnerabilities.

But in CI/CD, we want a build to **fail** if serious issues exist.



CI/CD uses exit code 1 to:
- Block deployments  
- Force review of vulnerabilities  
- Strengthen DevSecOps culture  

### Fail build if HIGH or CRITICAL found:
```
trivy image --severity HIGH,CRITICAL --exit-code 1 python:3.10
```

### Sample Output:
```
Found 3 HIGH vulnerabilities.
Exiting with code 1.
```

Pipeline stops because exit code 1 signals failure.

---

## Summary
- **--severity** → filter important vulnerabilities  
- **--vuln-type** → OS vs Library  
- **--exit-code** → fail CI/CD pipelines on security issues  
