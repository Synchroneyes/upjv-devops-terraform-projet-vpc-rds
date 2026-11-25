resource "aws_efs_file_system" "main" {
  creation_token = "projet-efs-main"
  encrypted      = true

  tags = {
    Name = "projet-efs-main"
  }
}

resource "aws_efs_mount_target" "private" {
  count = 3

  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = aws_subnet.private[count.index].id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_access_point" "main" {
  file_system_id = aws_efs_file_system.main.id

  root_directory {
    path = local.efs_mount_point

    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0755"
    }
  }

  posix_user {
    gid = 1000
    uid = 1000
  }

  tags = {
    Name = "projet-efs-access-point"
  }
}

data "aws_iam_policy_document" "efs_file_system_policy" {
  statement {
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.ec2_efs_ssm.arn]
    }

    resources = [aws_efs_file_system.main.arn]

    condition {
      test     = "StringEquals"
      variable = "elasticfilesystem:AccessPointArn"
      values   = [aws_efs_access_point.main.arn]
    }
  }
}

resource "aws_efs_file_system_policy" "main" {
  file_system_id = aws_efs_file_system.main.id
  policy         = data.aws_iam_policy_document.efs_file_system_policy.json
}
