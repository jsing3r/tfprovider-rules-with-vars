resource "wiz_cloud_configuration_rule" "test_ccr_rule" {
  name                      = "${var.initials_or_unique_id} Test CCR (AWS EC2 Instance Banned Tags)"
  description               = "${var.initials_or_unique_id} Test Cloud Configuration Rule (AWS EC2 Instance Banned Tags)"
  enabled                   = false
  target_native_types       = ["virtualMachine"] // Supported types: https://docs.wiz.io/wiz-docs/docs/supp-res-ccr
  remediation_instructions = "Remove banned tag key value pair from Virtual Machine"
  severity = "CRITICAL"
  security_sub_categories = [/*"276ef87c-7375-4565-a9d0-d7f3d5e95658"*/]
  opa_policy = templatefile("${path.module}/rego-templates/test_ccr_rule.tmpl.rego", {
      // Adding initial or unique ID. Formatted for rego and readibility in UI
      banned_tags = format("{\n\t%s\n}", join(",\n\t", [for tag in var.banned_tags : format("{\"key\": \"%s\", \"value\": \"%s\"}", "${var.initials_or_unique_id}-${tag.key}", "${var.initials_or_unique_id}-${tag.value}")]))
    })

  tags{
    key = "env"
    value = "${var.initials_or_unique_id}-test-ccr"
  }
}