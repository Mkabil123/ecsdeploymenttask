output "web_acl_arn" {
  description = "WAF web acl arn"
  value       = aws_wafv2_web_acl.waf_web_acl.arn
}