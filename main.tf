
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  filename          = "${var.namespace}-key.pem"
  content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.namespace}-key"
  public_key = tls_private_key.key.public_key_openssh
}

module "vpc" {
  source    = "./modules/vpc"
  namespace = var.namespace
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ec2" {
  source     = "./modules/ec2"
  namespace  = var.namespace
  vpc        = module.vpc.vpc
  sg_pub_id  = module.vpc.sg_pub_id
  sg_priv_id = module.vpc.sg_priv_id
  key_name   = aws_key_pair.key_pair.key_name
}