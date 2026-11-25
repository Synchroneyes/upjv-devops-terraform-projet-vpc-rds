data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_efs_ssm" {
  name               = "projet-ec2-efs-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name = "projet-ec2-efs-ssm-role"
  }
}

resource "aws_iam_instance_profile" "ec2_efs_ssm" {
  name = "projet-ec2-efs-ssm-instance-profile"
  role = aws_iam_role.ec2_efs_ssm.name
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_efs_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "efs_client" {
  statement {
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:DescribeMountTargets",
      "elasticfilesystem:DescribeFileSystems"
    ]

    resources = [
      aws_efs_file_system.main.arn,
      aws_efs_access_point.main.arn
    ]
  }
}

resource "aws_iam_policy" "efs_client" {
  name   = "projet-ec2-efs-client-policy"
  policy = data.aws_iam_policy_document.efs_client.json
}

resource "aws_iam_role_policy_attachment" "efs_client" {
  role       = aws_iam_role.ec2_efs_ssm.name
  policy_arn = aws_iam_policy.efs_client.arn
}
