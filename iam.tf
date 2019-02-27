data "aws_iam_policy_document" "transfer_server_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "transfer_server_to_cloudwatch_assume_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "transfer_server_role" {
  name               = "transfer_server_role"
  assume_role_policy = "${data.aws_iam_policy_document.transfer_server_assume_role.0.json}"
}

resource "aws_iam_role_policy" "transfer_server_policy" {
  name   = "transfer_server_policy"
  role   = "${aws_iam_role.transfer_server_role.name}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::${var.transfer_server_s3_bucket_name}",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::${var.transfer_server_s3_bucket_name}/*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObjectVersion",
                "s3:DeleteObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::${var.transfer_server_s3_bucket_name}/upload/*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt",
                "kms:GenerateDataKey",
                "kms:DescribeKey"
            ],
            "Resource": "arn:aws:kms:${var.transfer_server_region}:${var.transfer_server_account_id}:key/${var.transfer_server_kms_id}",
            "Effect": "Allow"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy" "transfer_server_to_cloudwatch_policy" {
  name   = "transfer_server_to_cloudwatch_policy"
  role   = "${aws_iam_role.transfer_server_role.name}"
  policy = "${data.aws_iam_policy_document.transfer_server_to_cloudwatch_assume_policy.0.json}"
}
