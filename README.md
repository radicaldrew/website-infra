# Nice Website

Terraform infrastructure for creating an ec2 instance
with nginx installed.

This creates a new ec2 instance with a simple "Hello World" index.html file. 
For this project tfstate was all saved locally. Final deployment of website is done with Jenkins.


### Requirments
- Terraform version: `>= 1.2.0`
- AWS account with programmatic access and necessary permissions (EC2)
- AWS cli installed and authenticated with keys 

### Outputs
- public_dns: The Public DNS address of the EC2 Instance
- public_ip: The Public IP address of the EC2 Instance

### Usage
Standard terraform usage applys

``terraform plan``

``terraform apply``
 - this will generate a .pem file for access to ec2 instance
 - output will show the ec2 instance public IP and DNS

``terraform destroy``


