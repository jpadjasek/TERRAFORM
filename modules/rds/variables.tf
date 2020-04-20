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
  default     = "jpadjasekTerraformRDS"
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
