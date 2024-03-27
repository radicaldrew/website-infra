variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string  
}

variable "namespace" {
  type      = string
  default   = "website"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "100.100.102.0/24"
}