#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Pull the DevScale Bank test application
docker pull devscalecloud/devscale-bank-test:v2

# Run the application and publish port 8080
docker run -d \
  --name devscale-bank-test \
  --restart unless-stopped \
  -p 8080:8080 \
  devscalecloud/devscale-bank-test:v2

