variable "ecr_name" {
  description = "The name of the ECR"
  type        = string
}

variable "scan_on_push" {
  description = "Whether to enable image scanning when pushing"
  type        = bool
  default     = true
}