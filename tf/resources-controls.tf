resource "wiz_control" "test_control" {
  name                      = "${var.initials_or_unique_id} Test Control (AWS EC2 Instance Banned Tags)"
  description               = "${var.initials_or_unique_id} Test Control using Graph QL Query (AWS EC2 Instance Banned Tags)"
  enabled                   = false
  severity                  = "LOW"
  resolution_recommendation = "Remove banned tag key value pair from Virtual Machine"
  security_sub_categories = [/*"wsct-id-8"*/]
  query = jsonencode(
    {
        "type": [
            "VIRTUAL_MACHINE"
        ],
        "select": true,
        "relationships": [
            {
            "type": [
                {
                "type": "HAS_TECH"
                }
            ],
            "with": {
                "type": [
                "TECHNOLOGY"
                ],
                "where": {
                "_externalID": {
                    "EQUALS": "3018"
                }
                }
            }
            }
        ],
        "where": {
            "tags": {
            //// Simple without formatting    
            // "TAG_CONTAINS_ANY": "${var.banned_tags}"

            // Formatted to include initials or unique id
            "TAG_CONTAINS_ANY": [for tag in var.banned_tags : {
                key   = "${var.initials_or_unique_id}-${tag.key}",
                value = "${var.initials_or_unique_id}-${tag.value}"
                }]
            }
        }
    }
  )
  scope_query = jsonencode(
    {
      "type" : [
        "VIRTUAL_MACHINE"
      ]
    }
  )
}