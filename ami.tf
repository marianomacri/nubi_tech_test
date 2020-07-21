# We'll use the latest version of Amazon Linux 2 to deploy the webservers

data "aws_ami" "amazonlinux2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }
  owners = ["amazon"]
}