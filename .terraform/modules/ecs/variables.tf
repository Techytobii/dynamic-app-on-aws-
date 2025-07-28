variable "ecr_repository_url" {
  description = "URL of the image in ECR"
  type        = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
