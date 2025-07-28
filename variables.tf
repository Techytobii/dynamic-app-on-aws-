variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "task_execution_role_arn" {
  type        = string
  description = "Existing IAM role ARN with ecsTaskExecution permissions"
}
