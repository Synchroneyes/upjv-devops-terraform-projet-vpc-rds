resource "random_password" "rds_master" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-_=+[]{}<>:?"
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

resource "aws_db_subnet_group" "main" {
  name       = "projet-rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "projet-rds-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier             = "projet-rds-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type           = "gp3"
  db_name                = "appdb"
  username               = "dbadmin"
  password               = random_password.rds_master.result
  port                   = 3306
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  multi_az               = false
  skip_final_snapshot    = true
  deletion_protection    = false
  apply_immediately      = true

  tags = {
    Name = "projet-rds-mysql"
  }
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "projet-rds-mysql-credentials"
  recovery_window_in_days = 0

  tags = {
    Name = "projet-rds-mysql-credentials"
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
