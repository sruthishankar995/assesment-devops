resource "aws_prometheus_workspace" "this" {
  alias = "${var.cluster_name}-amp"
}
