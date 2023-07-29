data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = var.ami_image_name
  }
}

resource "aws_instance" "Jenkins-ec2" {
  depends_on = [ module.Create_ECR_for_flask_app ]
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.admin_ec2.name
  vpc_security_group_ids      = [aws_security_group.project.id]

  tags = {
    Name = "Jenkins"
  }

  user_data = file("provision_scripts/setup_ec2.sh")
}