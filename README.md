# Terrakube Azure Active Directory Registration
Terraform module to register Terrakube application inside Azure Active Directory.

## Parameters
The module will require the following parameters:
- app_name
  - Application Name to register inside Azure Active Directory (Example: Terrakube)
- app_redirect_uri
  - Application redirect URI for the UI. Example: https://ui.terrakube.docker.internal

## Output Values

The module will output the following values:

- Azure Active Directory Application Id
- Azure Active Directory Tenat Id
- Azure Active Directory Application API URI
- Azure Active Directory Password

Example:

```bash
terraform apply --var "app_name=Terrakube" --var "app_redirect_uri=https://ui.terrakube.docker.internal/"


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

client_id = "XXXXXXXX"
client_password = <sensitive>
client_uri = "api://Terrakube"
tenat_id = "XXXXXXXX"
```

To see the value for the client password you can use the following command:

```bash
terraform console
nonsensitive(azuread_application_password.terrakube_api_password.value)
"XXXXXXXXXXXXXXXXXXXX"
```

> These values will be used to setup the Terrakube API. 

## API permissions
Terrakube application require Microsoft Graph access to:
- User.Read.All 
- Group.Read.All 
- GroupMember.Read.All
- Application.Read.All 

> You will have to ask a Azure Active Directory Tenant Administrator to grant these permissions.