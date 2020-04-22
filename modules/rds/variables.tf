variable "project_name" {
  description = "Project name that is going to prefix all created resources"
  default     = ""
}

variable "stage" {
  description = "Project stage"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "db_name" {
  description = "Db name"
  type        = string
  default     = "RDS"
}

variable "db_replica_name" {
  description = "Db name"
  type        = string
  default     = "RDSReplica"
}

variable "user_name" {
  description = "User name for db"
  type        = string
  default     = "admin"
}

variable "user_password" {
  description = "User password for db"
  type        = string
  default     = "Test12345!"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.1.0/24"
}

variable "cidr_subnet_2" {
  description = "CIDR block for the subnet"
  default = "10.1.2.0/24"
}


variable "db_subnet_group_name" {
  description = "The db subnet group name from the other module"
  default = "" 
}
