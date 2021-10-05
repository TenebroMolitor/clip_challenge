#----database/variables.tf----
variable "db_name" {
	type = string
}

variable "subnets" {
  type = list(string)
}
