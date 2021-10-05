#----networking/variables.tf----
variable "vpc_cidr" {
}

variable "private_cidrs" {
  type = list(string)
}

variable "accessip" {
}

