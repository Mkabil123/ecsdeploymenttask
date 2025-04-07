output "zone_id" {
  description = "The Hosted Zone id"
  value       = aws_route53_zone.hosted_zone.zone_id
}