output "vpc_id" {
  description = "ID of the VPC created by this module."
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of IDs for public subnets in the VPC."
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs for private subnets in the VPC."
  value = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway, or null if NAT is not created."
  value = try(aws_nat_gateway.main[0].id, null)
}

output "ssh_keypair_name" {
  description = "Name of the generated EC2 SSH key pair."
  value = aws_key_pair.generated.key_name
}

output "ssh_private_key_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the generated private SSH key."
  value = aws_secretsmanager_secret.keypair_private.arn
}

output "rds_endpoint" {
  description = "Connection endpoint of the MySQL RDS instance."
  value = aws_db_instance.mysql.endpoint
}

output "rds_credentials_secret_arn" {
  description = "ARN of the Secrets Manager secret containing RDS credentials."
  value = aws_secretsmanager_secret.rds_credentials.arn
}

output "efs_file_system_id" {
  description = "ID of the EFS file system."
  value = aws_efs_file_system.main.id
}

output "efs_access_point_id" {
  description = "ID of the EFS access point."
  value = aws_efs_access_point.main.id
}

output "efs_mount_info_secret_arn" {
  description = "ARN of the Secrets Manager secret with EFS mount information."
  value = aws_secretsmanager_secret.efs_mount_info.arn
}

output "ec2_efs_ssm_role_arn" {
  description = "ARN of the IAM role attached to EC2 instances for EFS and SSM access."
  value = aws_iam_role.ec2_efs_ssm.arn
}

output "ec2_efs_ssm_instance_profile_name" {
  description = "Name of the IAM instance profile for EC2 EFS/SSM role attachment."
  value = aws_iam_instance_profile.ec2_efs_ssm.name
}

output "ssm_vpc_endpoint_id" {
  description = "ID of the VPC endpoint for AWS Systems Manager (SSM)."
  value = aws_vpc_endpoint.ssm.id
}

output "ssmmessages_vpc_endpoint_id" {
  description = "ID of the VPC endpoint for AWS SSM Messages."
  value = aws_vpc_endpoint.ssmmessages.id
}

output "ec2messages_vpc_endpoint_id" {
  description = "ID of the VPC endpoint for AWS EC2 Messages."
  value = aws_vpc_endpoint.ec2messages.id
}

output "efs_vpc_endpoint_id" {
  description = "ID of the VPC endpoint for Amazon EFS."
  value = aws_vpc_endpoint.efs.id
}
