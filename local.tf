locals {
  app_name_base   = format("%s_base_%s", var.app_name, random_string.name_suffix.result)
  app_name_api    = format("%s_api_%s", var.app_name, random_string.name_suffix.result)
  identifier_uris = format("%s%s", "api://", var.app_name)
  homepage_url    = format("https://app.%s.net", var.app_name)
  logout_url      = format("https://app.%s.net/logout", var.app_name)
  app_role        = format("%s.Application.Default", var.app_name)

  oauth2Permissions = {
    admin_consent_description  = format("Allows the users to consume %s API", var.app_name)
    admin_consent_display_name = format("Access to %s API", var.app_name)
    user_consent_description   = format("Allows the users to consume %s API", var.app_name)
    user_consent_display_name  = format("Access to %s API", var.app_name)
    value = "Builder.Default"
  }
}