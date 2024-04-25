variable "WIZ_CLIENT_ID" {
  type      = string
  description = "You can set this via environment variable: export TF_VAR_WIZ_CLIENT_ID=\"<value>\""
  sensitive = true
}

variable "WIZ_CLIENT_SECRET" {
  type      = string
  description = "You can set this via environment variable: export TF_VAR_WIZ_CLIENT_SECRET=\"<value>\""
  sensitive = true
}

variable "initials_or_unique_id" {
  type      = string
  // default = "JDG"
  description = <<EOT
Enter initials or something unique to distiguish your rules (once deployed this identifier must stay the same to target deployed rules/queries). 
Recommended to set a default for initials_or_unique_id in the vars.tf file.
You can set this via environment variable: export TF_VAR_initials_or_unique_id="<value>"
EOT
}

// Simple variable example
variable "banned_IPs" {
  type    = list(string)
  description = "For testing use insert your public IP. Using AWS CLI, List users: aws iam list-users"

  default = [
    "138.88.70.62", 
    "138.88.70.00",
    "138.88.70.50"
    ]
}

// Complex object variable example
variable "banned_tags" {
  type = list(object({
    key   = string
    value = string
  }))
  description = <<EOT
For testing create an AWS EC2 micro instance and use a banned tag. (VMs can be scanned on demand).
Your initials or unique ID will be inserted (i.e. JDG-test-banned-tag-value-1).
EOT

  default = [
    { key = "banned-key-1", value = "banned-value-1" }, 
    { key = "banned-key-2", value = "banned-value-2" }, 
    { key = "banned-key-3", value = "banned-value-3" } 
  ]
}