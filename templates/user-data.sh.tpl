#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Run the application container
docker run -d -p 8080:8080 --restart unless-stopped devscalecloud/devscale-bank-test:v2
