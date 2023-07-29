resource "aws_iam_role" "admin_ec2" {
  name               = "admin_ec2"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "admin_ec2_policy_attachment" {
  role       = aws_iam_role.admin_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "admin_ec2" {
  name = "admin_ec2"
  role = aws_iam_role.admin_ec2.name
}