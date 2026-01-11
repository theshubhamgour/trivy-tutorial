# Trivy + Jenkins Production DevSecOps Project

This is a complete hands-on DevSecOps project using **Trivy** with **Jenkins**.

## Features
- Docker image build
- Trivy image vulnerability scanning
- JSON vulnerability report
- HTML security report
- SBOM generation (CycloneDX)
- Jenkins artifact archival

## Prerequisites
- Jenkins (Docker + Shell access)
- Docker
- Trivy installed on Jenkins node

## How it Works
1. Jenkins pulls source code
2. Builds Docker image
3. Trivy scans image
4. Reports generated and archived

## Output Artifacts
- reports/trivy-image.json
- reports/trivy-image.html
- reports/sbom.json

Perfect for:
- DevSecOps portfolio
- YouTube demos
- Interview projects
