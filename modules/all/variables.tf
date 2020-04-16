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

variable "availability_zone_1" {
  description = "availability zone to create subnet"
  default = "eu-west-2a"
}

variable "availability_zone_2" {
  description = "availability zone to create subnet"
  default = "eu-west-2b"
}
