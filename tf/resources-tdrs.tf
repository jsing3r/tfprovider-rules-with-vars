resource "wiz_threat_detection_rule" "test_tdr_cloud_event_filter_rule" {
  name = "${var.initials_or_unique_id} Test TDR Cloud Event Filter Rule (AWS ListUsers Banned IP)"
  description = "${var.initials_or_unique_id} This is a test Threat Detection Cloud Event Filter Rule (AWS ListUsers Banned IP)"
  enabled = false
  severity =  "CRITICAL"
  security_sub_categories = [/*"wsct-id-9468", "wsct-id-9469"*/]
  generate_findings = false
  generate_issues = false
  perform_cloud_event_type_validation = false
  params {
    cloud_providers = ["AWS"]
    filters = jsonencode({
        "and": [
            {
                "externalName": {
                "equals": [
                    "ListUsers"
                ]
                },
                "actor": {
                "IP": {
                    "contains": "${var.banned_IPs}"
                }
                }
            }
        ]
    })
  }
}

resource "wiz_threat_detection_rule" "test_tdr_rego_rule" {
  name = "${var.initials_or_unique_id} Test TDR Rego Rule (AWS ListUsers Banned IP)"
  description = "${var.initials_or_unique_id} This is a test Threat Detection Rego Rule (AWS ListUsers Banned IP)"
  enabled = false
  severity =  "CRITICAL"
  security_sub_categories = [/*"wsct-id-9468", "wsct-id-9469"*/]
  generate_findings = false
  generate_issues = false
  params {
    target_event_names = ["ListUsers"]
    cloud_providers = ["AWS"]
    opa_matcher = templatefile("${path.module}/rego-templates/test_tdr_rego_rule.tmpl.rego", {
        // Formatted for rego and readibility in UI
        banned_IPs = format("{\n\t\"%s\"\n}", join("\",\n\t\"", var.banned_IPs))
    })
  }
}