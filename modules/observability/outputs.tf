output "prometheus_workspace_id" {
  value = aws_prometheus_workspace.this.id
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
