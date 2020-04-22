variable "project_name" {
  description = "Project name that is going to prefix all created resources"
  default     = ""
}

variable "stage" {
  description = "Project stage"
  type        = string
  default     = ""
}

variable "security_group_id" {
  description = "Security group id"
  type        = string
}

variable "subnet_id_1" {
  description = "Subnet id"
  type        = string
}

variable "subnet_id_2" {
  description = "Subnet id"
  type        = string
}

variable "server_port" {
  description = "Security group id"
  type        = string
  default     = "8080"
}
