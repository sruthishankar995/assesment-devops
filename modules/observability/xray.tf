resource "aws_xray_sampling_rule" "default" {
  rule_name      = "${var.cluster_name}-xray-rule"
  priority       = 100
  reservoir_size = 1
  fixed_rate     = 0.05
  host           = "*"
  http_method    = "*"
  url_path       = "*"
  version        = 1
}
