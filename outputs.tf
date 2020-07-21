output "alb_dns" {
  description = "Website URL"
  value       = "http://${aws_lb.alb.dns_name}"
}