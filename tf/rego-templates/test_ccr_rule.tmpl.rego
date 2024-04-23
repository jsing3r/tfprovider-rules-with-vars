#	based on the raw JSON of a resource. By default, every resource with the selected
#	Native Type will be assessed and have either 'fail' or 'pass' results.
# 
#	You must populate the 'result' variable in either of the following string:
#	1. "pass" - The rule resource assessment will be set as "pass".
#				Will not result in a Configuration Finding.
#	2. "fail" - The rule resource assessment will be set as "failed".
#				Will result in a Configuration Finding associated with the resource.
#	3. "skip" - The resource will not be assessed and will not be counted in compliance reporting.
#
#	To control the Expected Configuration and Current Configuration of a failed rule, use the
#	'currentConfiguration' and 'expectedConfiguration' variables.
#
#	To use built-in future Rego functions, such as 'in', 'contains', 'every', and 'if' - add
#	'import future.keywords' to the code.

package wiz

default result := "pass"

banned_tags := ${banned_tags}

has_banned_tag(instance) {
    tag := instance.Tags[_] # Ensure the capitalization matches the input JSON structure, 'Tags' should be capitalized
    banned_tag := banned_tags[_]
    tag.Key == banned_tag.key
    tag.Value == banned_tag.value
}

result := "fail" {
    has_banned_tag(input) 
}

violation[{"msg": msg}] {
    has_banned_tag(input)
    msg := sprintf("Remove banned tag key value pair from Virtual Machine", [])
}

# currentConfiguration := sprintf("", [])
# expectedConfiguration := sprintf("", [])