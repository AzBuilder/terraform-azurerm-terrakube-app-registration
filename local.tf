locals {
  app_name_base   = format("%s Base", var.app_name)
  app_name_api    = format("%s App", var.app_name)
  app_name_cli    = format("%s Cli", var.app_name)
  identifier_uris = format("%s%s", "api://", var.app_name)
  app_redirect_uri = split(",",format("http://localhost:10000/login,http://localhost:10001/login,%s", var.app_redirect_uri))
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