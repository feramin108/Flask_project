provider "aws" {
  region = var.aws_region  # Use the variable for the AWS region
}

# Generate a private key
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key to a local file
resource "local_file" "private_key" {
  content  = tls_private_key.example_key.private_key_pem
  filename = "${path.module}/flask-app-key.pem"
}

# Create an SSH key pair in AWS
resource "aws_key_pair" "app_key" {
  key_name   = "flask-app-key"
  public_key = tls_private_key.example_key.public_key_openssh
}

# Create a security group to allow HTTP and SSH access
resource "aws_security_group" "app_sg" {
  name        = "flask-app-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance and associate it with the security group
resource "aws_instance" "app_server" {
  ami           = var.ami_id  # Use the variable for AMI ID
  instance_type = var.instance_type  # Use the variable for instance type

  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name                = aws_key_pair.app_key.key_name

  tags = {
    Name = "FlaskAppServer"
  }
}

# Output the key name and the location of the private key file
output "key_name" {
  value = aws_key_pair.app_key.key_name
}

output "private_key_path" {
  value = local_file.private_key.filename
}
