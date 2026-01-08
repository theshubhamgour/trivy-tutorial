#!/bin/bash

read -p "Enter image name : " IMAGE
DATE=$(date +"%Y-%m-%d_%H-%M")
REPORT_DIR="trivy-reports"

mkdir -p $REPORT_DIR

echo "Starting Trivy scan for $IMAGE"
echo "Scan time: $DATE"

trivy image \
  --severity HIGH,CRITICAL \
  --format table \
  $IMAGE > $REPORT_DIR/trivy-scan-$DATE.txt

echo "Scan completed"
echo "Report saved to $REPORT_DIR/trivy-scan-$DATE.txt"

