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

output "efs_file_system_id" {
  value = aws_efs_file_system.main.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.main.id
}

output "efs_mount_info_secret_arn" {
  value = aws_secretsmanager_secret.efs_mount_info.arn
}

output "ec2_efs_ssm_role_arn" {
  value = aws_iam_role.ec2_efs_ssm.arn
}

output "ec2_efs_ssm_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_efs_ssm.name
}

output "ssm_vpc_endpoint_id" {
  value = aws_vpc_endpoint.ssm.id
}

output "ssmmessages_vpc_endpoint_id" {
  value = aws_vpc_endpoint.ssmmessages.id
}

output "ec2messages_vpc_endpoint_id" {
  value = aws_vpc_endpoint.ec2messages.id
}

output "efs_vpc_endpoint_id" {
  value = aws_vpc_endpoint.efs.id
}
