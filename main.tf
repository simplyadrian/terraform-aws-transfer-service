module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.5"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_transfer_server" "transfer_server" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = "${aws_iam_role.transfer_server_role.arn}"

  tags       = "${module.label.tags}"
}

resource "aws_transfer_user" "transfer_server_user" {
  server_id      = "${aws_transfer_server.transfer_server.id}"
  user_name      = "${var.transfer_server_user_name}"
  role           = "${aws_iam_role.transfer_server_role.arn}"
  home_directory = "/${var.transfer_server_s3_bucket_name}"

  tags       = "${module.label.tags}"
}

resource "aws_transfer_ssh_key" "transfer_server_ssh_key" {
  server_id = "${aws_transfer_server.transfer_server.id}"
  user_name = "${aws_transfer_user.transfer_server_user.user_name}"
  body      = "${var.transfer_server_ssh_key}"
}

module "transfer_server_dns_host_name" {
  source    = "git::https://github.com/IDS-Inc/terraform-aws-route53-cluster-hostname.git?ref=master"
  namespace = "${var.namespace}"
  name      = "${var.transfer_server_host_name}"
  stage     = "${var.stage}"
  ttl       = "${var.transfer_server_ttl}"
  type      = "${var.transfer_server_dns_record_type}"
  zone_id   = "${var.transfer_server_parent_zone_id}"
  records   = "${aws_transfer_server.transfer_server.endpoint}"
  enabled   = "${(length(var.transfer_server_parnet_zone_id) > 0 && var.enabled == "true") ? "true" : "false"}"
}
