#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Run the container in detached mode on port 8080

docker run -d -p 8080:8080 --restart unless-stopped devscalecloud/devscale-bank-test:v2


