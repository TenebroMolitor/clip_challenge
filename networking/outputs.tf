#-----networking/outputs.tf----

output "private_subnets" {
  value = aws_subnet.tf_private_subnet.*.id
}

output "private_sg" {
  value = aws_security_group.tf_private_sg.id
}

output "subnet_ips" {
  value = aws_subnet.tf_private_subnet.*.cidr_block
}

