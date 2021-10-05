#-----compute/main.tf#-----

data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "tf_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "tf_server" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id

  tags = {
    Name = "tf_server-${count.index + 1}"
  }
  
  user_data = <<-EOF
    mysql -u clipdba -p -h cliptest.czdktelbpy13.us-west-1.rds.amazonaws.com
	CREATE TABLE pet (
		id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(20) NULL,
		owner VARCHAR(20) NULL,
		species VARCHAR(20) NULL,
		sex CHAR(1) NULL,
	) 
  EOF

  key_name               = aws_key_pair.tf_auth.id
  vpc_security_group_ids = [var.security_group]
  subnet_id              = element(var.subnets, count.index)
}

