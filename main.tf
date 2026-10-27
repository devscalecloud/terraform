terraform {
  required_version = "> 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# Look up the existing VPC and subnet (they are NOT created by Terraform)
data "aws_vpc" "main" {
  id = "vpc-06246eb6b0e21e813"
}

data "aws_subnet" "main" {
  id = "subnet-0f62723b0fb0069ec"
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    description = "App on 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

resource "aws_instance" "devscale_test_server" {
  ami                         = "ami-0d31a22b09ceec4db" # AMI IDs are region-specific
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = file("templates/user-data.sh.tpl")

  tags = {
    Name = var.project_name
  }
}
