# Terrakube Azure Active Directory Registration
Terraform module to register Terrakube application inside Azure Active Directory.

## Parameters
| Name     | Description                           | 
|----------|---------------------------------------|
| app_name | Application Name (Example: Terrakube) | 

## Output Values
| Name            | Description      | 
|-----------------|------------------|
| client_id       | Application Id   | 
| client_uri      | Client URI       | 
| client_password | Client Password  |

> (These values are used inside the Terrakube API) 

## API permissions
Terrakube application require Microsoft Graph access to User.Read.All, Group.Read.All, GroupMember.Read.All, a tenant Admin will need to grant these permissions