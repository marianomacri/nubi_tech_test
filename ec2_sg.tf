# Only HTTP traffic will be allowed to the instances, since we do not have a bastion host to SSH.
# SSM will be used to manage the instances.

resource "aws_security_group" "webserver_sg" {
  name        = "Webservers SG"
  description = "Security Group for the Webservers"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "HTTP Access"
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}