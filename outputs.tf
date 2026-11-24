output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  value = try(aws_nat_gateway.main[0].id, null)
}

output "ssh_keypair_name" {
  value = aws_key_pair.generated.key_name
}

output "ssh_private_key_secret_arn" {
  value = aws_secretsmanager_secret.keypair_private.arn
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "rds_credentials_secret_arn" {
  value = aws_secretsmanager_secret.rds_credentials.arn
}
