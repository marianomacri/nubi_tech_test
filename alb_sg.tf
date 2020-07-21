# Only HTTP ingress traffic is allowed to the ALB

resource "aws_security_group" "alb_sg" {
  name        = "ALB SG"
  description = "Security Group for the Application Load Balancer"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP Access"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /*ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS access"
    cidr_blocks = ["0.0.0.0/0"]
  }*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}