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

variable "transfer_server_region" {
  type        = "string"
  description = "The current AWS region"
}

variable "transfer_server_account_id" {
  type        = "string"
  description = "The current AWS account id"
}

variable "transfer_server_s3_bucket_name" {
  type        = "string"
  description = "The S3 bucket name you want to use for a home directory"
}

variable "transfer_server_hostname" {
  type        = "string"
  description = "The hostname value you want used as a DNS record (e.g. `example`)"
}

variable "transfer_server_ttl" {
  type        = "string"
  description = "The DNS records time to live in seconds (e.g. `60`, `120`, `300`)"
}

variable "transfer_server_dns_record_type" {
  type        = "string"
  description = "The DNS record type (e.g. `A` or `CNAME`)"
}

variable "transfer_server_parent_zone_id" {
  type        = "string"
  description = "The route53 zone id you want to create an alias in"
}

variable "transfer_server_kms_id" {
  type        = "string"
  description = "If your S3 bucket is encrypted with a KMS key, you will refer to the S3 kms_id here"
}

variable "transfer_server_name" {
  type        = "string"
  description = "Transfer Server name"
}

variable "transfer_server_user_name" {
  type        = "string"
  description = "User name for SFTP server"
}

variable "transfer_server_ssh_key" {
  type        = "string"
  description = "SSH Key for transfer server user"
}
