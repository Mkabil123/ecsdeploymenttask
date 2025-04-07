resource "aws_sns_topic" "email_alert_sns_topic" {
  name = "${var.env_name}${var.app_name}-email-alert"
  tags = var.common_tags
}

# Create SNS subscriptions for each email address
resource "aws_sns_topic_subscription" "email_alert_subscriptions" {
  for_each = toset(var.alert_email_addresses)

  topic_arn = aws_sns_topic.email_alert_sns_topic.arn
  protocol  = "email"
  endpoint  = each.value
}
