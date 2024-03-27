output "aws_instance_public_dns" {
  value = module.ec2.public_dns
}

output "aws_instance_public_ip" {
  value = module.ec2.public_ip
}