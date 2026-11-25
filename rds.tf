resource "random_password" "rds_master" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-_=+[]{}<>:?"
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
