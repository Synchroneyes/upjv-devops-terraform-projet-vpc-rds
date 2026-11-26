resource "aws_secretsmanager_secret" "efs_mount_info" {
  name                    = "projet-efs-mount-info-2"
  recovery_window_in_days = 0

  tags = {
    Name = "projet-efs-mount-info-2"
  }
}

resource "aws_secretsmanager_secret_version" "efs_mount_info" {
  secret_id = aws_secretsmanager_secret.efs_mount_info.id

  secret_string = jsonencode({
    os_target                     = "amazon-linux-2023"
    ec2_mount_point               = local.efs_mount_point
    commande_amazonlinux_2023     = "sudo yum install -y amazon-efs-utils && mkdir -p ${local.efs_mount_point}"
    commande_verification_montage = "mount -a"
    contenu_fstab                 = "${aws_efs_file_system.main.id}:/ ${local.efs_mount_point} efs _netdev,tls,iam,accesspoint=${aws_efs_access_point.main.id} 0 0"
  })
}

resource "aws_secretsmanager_secret" "keypair_private" {
  name                    = "keypair-projet-upjv-private-2"
  recovery_window_in_days = 0

  tags = {
    Name = "keypair-projet-upjv-private-2"
  }
}

resource "aws_secretsmanager_secret_version" "keypair_private" {
  secret_id = aws_secretsmanager_secret.keypair_private.id

  secret_string = jsonencode({
    key_name    = aws_key_pair.generated.key_name
    private_key = tls_private_key.ssh.private_key_pem
    public_key  = tls_private_key.ssh.public_key_openssh
  })
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "projet-rds-mysql-credentials-2"
  recovery_window_in_days = 0

  tags = {
    Name = "projet-rds-mysql-credentials-2"
  }
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id

  secret_string = jsonencode({
    engine   = aws_db_instance.mysql.engine
    host     = aws_db_instance.mysql.address
    port     = aws_db_instance.mysql.port
    db_name  = aws_db_instance.mysql.db_name
    username = aws_db_instance.mysql.username
    password = random_password.rds_master.result
  })
}
