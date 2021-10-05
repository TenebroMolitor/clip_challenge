aws_region   = "us-west-1"
project_name = "clip-terraform"
vpc_cidr     = "10.123.0.0/16"
private_cidrs = [
  "10.123.1.0/24",
  "10.123.2.0/24"
]
accessip    = "0.0.0.0/0"
key_name = "tf_key"
public_key_path = "c:\\Users\\Josue\\Documents\\Terraform\\AWS\\compute\\key_ec2s.pub"
server_instance_type = "t2.micro"
instance_count = 1
db_name = "cliptest"