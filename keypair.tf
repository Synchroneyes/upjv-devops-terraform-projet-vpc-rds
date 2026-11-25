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
