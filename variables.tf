variable "project_name" {
  description = "Project name"
  type        = string
  default     = "jpadjasek-terraform"
}

variable "stage" {
  description = "Name of stage for current environment"
  type        = string
  default     = "dev1"
}
