output "test_ccr_rule" {
  value       = wiz_cloud_configuration_rule.test_ccr_rule.name
}

output "test_tdr_cloud_event_filter_rule" {
  value       = wiz_threat_detection_rule.test_tdr_cloud_event_filter_rule.name
}

output "test_tdr_rego_rule" {
  value       = wiz_threat_detection_rule.test_tdr_rego_rule.name
}

output "test_control" {
  value       = wiz_control.test_control.name
}