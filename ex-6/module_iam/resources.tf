data "aws_caller_identity" "this" {}

resource "aws_iam_role" "this" {
  name               = "${var.users["group"].name}-role"
  path               = "/system/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "this" {
  name        = "${var.users["group"].name}-policy"
  path        = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.this.arn
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_group" "this" {
  name = var.users["group"].name
}

resource "aws_iam_group_membership" "this" {
  name = "${var.users["group"].name}-membership"

  users =  [ for user in aws_iam_user.this: user.name ]

  group = aws_iam_group.this.name
}

resource "aws_iam_user" "this" {
  for_each = toset(var.users["users"])
  name = each.key
}
