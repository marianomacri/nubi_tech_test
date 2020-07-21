data "aws_iam_policy_document" "webserver_ec2_assume_role" {
  # Create policy document allowing EC2 and SSM assumerole access
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ssm.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "webserver_ec2_role" {
  # IAM Role for the webservers
  name               = "ec2role_webserver"
  assume_role_policy = data.aws_iam_policy_document.webserver_ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "SSM_policy_attach" {
  role       = aws_iam_role.webserver_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_instance_profile" "webserver_instance_profile" {
  # Instance profile to apply to the webservers
  name = "ec2profile_webserver"
  role = aws_iam_role.webserver_ec2_role.name
}

data "aws_iam_policy_document" "ec2_cloudwatch_access" {
  # Policy Document allowing access to write cloudwatch logs
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "webserver_cloudwatch_access_attach" {
  role       = aws_iam_role.webserver_ec2_role.name
  policy_arn = aws_iam_policy.ec2_cloudwatch_access.arn
}

resource "aws_iam_policy" "ec2_cloudwatch_access" {
  policy      = data.aws_iam_policy_document.ec2_cloudwatch_access.json
  name_prefix = "ec2-cw-"
  description = "Grant webservers access to CloudWatch logging"
}