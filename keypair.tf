resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = "keypair-projet-upjv"
  public_key = tls_private_key.ssh.public_key_openssh

  tags = {
    Name = "keypair-projet-upjv"
  }
}

resource "aws_secretsmanager_secret" "keypair_private" {
  name                    = "keypair-projet-upjv-private"
  recovery_window_in_days = 0

  tags = {
    Name = "keypair-projet-upjv-private"
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
