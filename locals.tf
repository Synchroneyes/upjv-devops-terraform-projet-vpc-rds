locals {
  vpc_cidr = "10.0.0.0/16"

  aws_region = "eu-north-1"

  enable_nat_gateway = true

  subnet_azs = [
    "eu-north-1a",
    "eu-north-1b",
    "eu-north-1c"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]

  efs_mount_point = "/var/www/html"
}
