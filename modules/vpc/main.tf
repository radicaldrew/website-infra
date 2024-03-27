
data "aws_availability_zones" "available" {}

module "vpc" {
  source = "../terraform-aws-vpc"
  name                             = "${var.namespace}-vpc"
  #cidr                             = "10.0.0.0/16"
  availability_zones               = data.aws_availability_zones.available.names
  private_subnets                  = var.private_subnet_cidrs
  public_subnets                   = var.public_subnet_cidrs
  enable_nat_gateway               = true
  single_nat_gateway               = true
}

resource "aws_security_group" "allow_ssh_http_pub" {
  name        = "${var.namespace}-allow_ssh_http"
  description = "Allow HTTP/SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP traffic from the internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-allow_ssh_http_pub"
  }
}

resource "aws_security_group" "allow_ssh_http_priv" {
  name        = "${var.namespace}-allow_ssh_http_priv"
  description = "Allow HTTP/SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH only from internal VPC clients"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "HTTP traffic from internal VPC clients"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-allow_ssh_http_priv"
  }
}