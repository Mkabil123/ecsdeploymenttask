resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
  tags = var.common_tags
}

// Route 53 records for subdomains
resource "aws_route53_record" "admin_dns" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "${var.admin_domain_name}.${var.domain_name}"
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
