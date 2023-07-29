variable "aws_region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}

# example ["al2023-ami-*"] it will be latest Amazon Linux 2023 AMI

variable "ami_image_name" {
  description = "Amazon Machine Image (AMIs) name"
  type        = list(string)
  default     = ["amzn2-ami-hvm-*"]
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.medium"
}