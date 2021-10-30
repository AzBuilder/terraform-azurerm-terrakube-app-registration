output "client_id" {
  value       = azuread_application.terrakube_api.application_id
  description = "Azure Active Directory Application Id"
}

output "client_uri" {
  value       = local.identifier_uris
  description = "Azure Active Directory Application URI"
}

output "client_password" {
  value       = azuread_application_password.terrakube_api_password.value
  description = "Azure Active Directory Password"
  sensitive   = true
}