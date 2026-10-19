#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker

# Start and enable Docker
systemctl start docker
systemctl enable docker