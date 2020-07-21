resource "aws_lb_target_group" "webservers_tg" {
  name     = "webservers-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "nginx_tg_attachment" {
  target_group_arn = aws_lb_target_group.webservers_tg.arn
  target_id        = aws_instance.nginx_webserver.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "apache_tg_attachment" {
  target_group_arn = aws_lb_target_group.webservers_tg.arn
  target_id        = aws_instance.apache_webserver.id
  port             = 80
}