# Scanning Docker Images Locally – Real-World Demo
Beginner-Friendly Hands-On Guide Using Trivy & Docker

## 📌 Overview
Learn how to scan Docker images locally using Trivy, understand caching, and fix common vulnerabilities.

Included:
- Dockerfile
- Dockerfileissue (The Dockerfile with vulnerablilties)
- app.py
- README.md

## 🚀 1. Build the Local Docker Image
```
docker build -t myapp:latest .
```

## 🛡️ 2. Scan the Image Using Trivy
```
trivy image myapp:latest
```

## ⚡ 3. Trivy Caching Locations
macOS:
```
~/Library/Caches/trivy
```
Linux:
```
~/.cache/trivy
```

## 🔧 4. Fixing Vulnerabilities
```
FROM python:3.10-slim
RUN pip install --upgrade pip
RUN pip install flask
COPY app.py .
CMD ["python","app.py"]
```
Rebuild:
```
docker build -t myapp:secure .
```

## 📊 5. Example Scan Output
```
Total: 42 (LOW: 30, MEDIUM: 10, HIGH: 2, CRITICAL: 0)
```

## 🎥 Watch the Full Episode
Add YouTube link here.

## 💬 Support
Comment on the video or open an issue.
