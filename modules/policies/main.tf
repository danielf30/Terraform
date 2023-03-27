data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "s3_policy" {
  count = var.create_policy ? 1 : 0
  name   = "s3-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
  lifecycle {
    ignore_changes = [
      policy
    ]
  }
}

data "aws_iam_policy" "s3_policy" {
  count = var.create_policy ? 1 : 0
  arn = aws_iam_policy.s3_policy.0.arn
}

resource "aws_iam_policy" "group_policy" {
  count = var.create_policy ? 1 : 0
  name = "dominio-${var.central_name}-group-policy-s3"
  policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
                {
                    Sid = "PublicRead",
                    Effect = "Allow",
                    Action = [
                        "s3:GetObject", "s3:PutObject", "s3:DeleteObject"
                    ],
                    Resource = [
                        "${var.s3_bucket_arn}/*"
                    ]
                }
            ]
        })
}

output "aws_iam_policy_arn" {
  value = aws_iam_policy.s3_policy.*.arn
}

resource "aws_iam_role" "glue_job_role" {
  name = "glue_job_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "glue_job_policy" {
  name = "glue_job_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "glue:GetJob",
              "glue:UpdateJob",
              "glue:DeleteJob",
              "glue:CreateJob",
              "glue:GetJobRun",
              "glue:BatchStopJobRun",
              "glue:StartJobRun",
              "glue:StopJobRun"
            ],
            "Resource": "arn:aws:glue:*:*:job/*"
        },
        {
            "Effect": "Allow",
            "Action": [
              "glue:CreateConnection",
              "glue:DeleteConnection",
              "glue:UpdateConnection",
              "glue:GetConnection",
              "glue:GetConnections"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "glue:GetDatabase",
                "glue:GetTables",
                "glue:CreateTable",
                "glue:UpdateTable",
                "glue:DeleteTable",
                "glue:GetTableVersions",
                "glue:GetTable",
                "glue:BatchCreatePartition",
                "glue:BatchDeletePartition",
                "glue:GetPartitions",
                "glue:CreatePartition",
                "glue:DeletePartition"
            ],
            "Resource": [
                "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:catalog",
                "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:database/${var.database_glue}",
                "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:table/my_database/*"
            ]
        }
      ]
  })
}
