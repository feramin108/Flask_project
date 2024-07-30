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
  ami           = "ami-050590538bdcb706b"  # Replace with your preferred AMI
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "FlaskAppServer"
  }
}
