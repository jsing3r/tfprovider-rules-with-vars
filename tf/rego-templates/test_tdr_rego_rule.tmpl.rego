#  Use the Rego code below to programmatically define a custom Threat Detection Rule
#  on the Audit logs ingested by Wiz.
#
#  You must populate the 'match' variable with the following string:
#	1. "true" - The rule will generate a threat detection rule result.
#   2. "false" - The rule not generate a threat detection result.

banned_ips := ${banned_IPs}

is_ip_banned(ip) {
    ip == banned_ips[_]
}

match {
    input.RawJson.eventName == "ListUsers"
    is_ip_banned(input.RawJson.sourceIPAddress)
}