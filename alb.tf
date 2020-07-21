resource "aws_lb" "alb" {
  name               = "public-alb-nubi-webservers"
  subnets            = var.public_subnet_ids
  ip_address_type    = "ipv4"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  load_balancer_type = "application"

  lifecycle {
    create_before_destroy = true
  }

  access_logs {
    bucket  = aws_s3_bucket.logs.bucket
    prefix  = aws_s3_bucket.logs.bucket_prefix
    enabled = true
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webservers_tg.arn
  }
}

# We won't listen on port 443 since we do not have a domain that we can use, so we don't have a certificate to put on the ALB

/*resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webservers_tg.arn
  }
}*/