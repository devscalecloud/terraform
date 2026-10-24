#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker

# Start and enable Docker
systemctl start docker
systemctl enable docker

#Run the application on host port 8080
docker run -d \
  --restart unless-stopped \
  -p 8080:8080 \
  devscalecloud/devscale-bank-test:v2
  
