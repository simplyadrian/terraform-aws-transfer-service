variable "name" {
  type        = "string"
  description = "The Name of the application or solution  (e.g. `bastion` or `portal`)"
}

variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `eg` or `cp`)"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "region" {
  description = "The current AWS region"
  default = "${data.aws_region.current.name}"
}

variable "account_id" {
  description = "The current AWS account id"
  default = "${data.aws_caller_identity.current.account_id}"
}

variable "s3_bucket_name" {
  description = "The S3 bucket name you want to use for a home directory"
}

variable "kms_id" {
  description = "The S3 KMS key id"
}

variable "transfer_server_name" {
  description = "Transfer Server name"
}

variable "transfer_server_user_name" {
  description = "User name for SFTP server"
}

variable "transfer_server_ssh_key" {
  description = "SSH Key for transfer server user"
}
