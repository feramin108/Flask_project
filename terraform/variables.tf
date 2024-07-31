# Define the AWS region as a variable
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2" # Replace with your preferred region
}

# Define the instance type as a variable
variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

# Define the AMI ID as a variable
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-050590538bdcb706b" # Replace with your preferred AMI
}
