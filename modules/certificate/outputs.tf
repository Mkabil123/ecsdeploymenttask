output "ssl_certificate_arn" {
  description = "SSL certificate arn"
  value       = aws_acm_certificate.ssl.arn
}