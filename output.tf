output "transfer_server_id" {
  value = "${aws_transfer_server.transfer_server.id}"
}

output "transfer_server_endpoint" {
  value = "${aws_transfer_server.transfer_server.endpoint}"
}

output "transfer_server_account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "transfer_server_region" {
  value = "{data.aws_region.current.name}"
}
