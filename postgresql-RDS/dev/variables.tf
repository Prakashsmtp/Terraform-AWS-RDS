variable "account_id" {
  description = "Your AWS account ID"
  type        = string
}

variable "iam_role_name" {
  description = "The IAM role name that Terraform will assume"
  type        = string
}
