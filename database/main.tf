#---------storage/main.tf---------

# Creates a RDS
resource "aws_db_instance" "tf_rds_main" {
  allocated_storage    = 100
  storage_type         = "io1"
  iops                 = 1000
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.m3.medium"
  multi_az             = false
  identifier 		   = var.db_name
  name                 = var.db_name
  username             = "clipdba"
  password             = "clipdba12345"
  deletion_protection  = false
  skip_final_snapshot  = true
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.tf_subnet.id
}

resource "aws_db_subnet_group" "tf_subnet" {
  name        = "tf_subnet_group"
  description = "Used for deploy the private RDS" 
  subnet_ids  = var.subnets
}
