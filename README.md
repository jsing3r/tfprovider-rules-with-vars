# tfprovider-rules-with-vars
Examples of using Wiz Terraform Provider to handle rules with constants and variables at scale.  Experience with Terraform is assumed for this project.

## Directions
- Setup the required service account in Wiz.  
- cd into TF folder
- Set Wiz service account credentials and initials or something unique to identify your rules in Wiz.  You can set as environment variables (otherwise follow prompts when using terraform commands)
   ```
    export TF_VAR_WIZ_CLIENT_ID="<value>"
    export TF_VAR_WIZ_CLIENT_SECRET="<value>"
    export TF_VAR_initials_or_unique_id="<value>"
- Run terraform init, plan and/or apply to add rules.
- Run terraform destroy, to remove rules.
- To simulate rule conditions, follow the descriptions of the rules and vars.

## Rules to be deployed

### Graph Query Controls
- Test Control (AWS EC2 Instance Banned Tags)

### Cloud Configuration Rules (CCRs)
- Test CCR (AWS EC2 Instance Banned Tags)

### Threat Detection Rules (TDRs)
-   Test TDR Cloud Event Filter Rule (AWS ListUsers Banned IP)
-   Test TDR Rego Rule (AWS ListUsers Banned IP)


## Notes
Rule titles must stay the same to target for updates and to destroy.  If state becomes inconsistent you can just cut out the broken rule resource, apply the terraform (to remove broken rule from Wiz), re-paste the rule resource back in and reapply to restore fixed rule.