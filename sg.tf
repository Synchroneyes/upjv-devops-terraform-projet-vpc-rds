resource "aws_security_group" "efs" {
  name        = "projet-efs-sg"
  description = "Allow NFS access to EFS from inside the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "NFS from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "projet-efs-sg"
  }
}

resource "aws_security_group" "vpce" {
  name        = "projet-vpce-sg"
  description = "Allow HTTPS to VPC endpoints from inside the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "projet-vpce-sg"
  }
}

resource "aws_security_group" "rds" {
  name        = "projet-rds-sg"
  description = "Allow MySQL access from inside the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "projet-rds-sg"
  }
}
