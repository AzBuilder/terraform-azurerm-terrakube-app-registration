resource "random_uuid" "app_role_id" {
}

resource "random_uuid" "oauth2_permission_scope" {
}

resource "random_string" "name_suffix" {
  length           = 4  
  special          = false
}

resource "azuread_application" "terrakube_base" {
  display_name     = local.app_name_base
  identifier_uris  = [local.identifier_uris]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  app_role {
    allowed_member_types = ["Application"]
    description          = local.app_role
    display_name         = local.app_role
    enabled              = true
    id                   = random_uuid.app_role_id.result
    value                = local.app_role
  }

  api {
    requested_access_token_version = 1

    oauth2_permission_scope {
      admin_consent_description  = local.oauth2Permissions.admin_consent_description
      admin_consent_display_name = local.oauth2Permissions.admin_consent_display_name
      enabled                    = true
      id                         = random_uuid.oauth2_permission_scope.result
      type                       = "User"
      user_consent_description   = local.oauth2Permissions.user_consent_description
      user_consent_display_name  = local.oauth2Permissions.user_consent_display_name
      value                      = "Builder.Default"
    }

  }

}

resource "azuread_service_principal" "terrakube_service_principal" {
  application_id               = azuread_application.terrakube_base.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application" "terrakube_api" {
  display_name     = local.app_name_api
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
  fallback_public_client_enabled = true

  required_resource_access {
    resource_app_id =  azuread_application.terrakube_base.application_id 

    resource_access {
      id   =  azuread_application.terrakube_base.app_role.*.id[0] # Builder.Application.Default
      type = "Role"
    }

    resource_access {
      id   =  azuread_application.terrakube_base.api.*.oauth2_permission_scope[0].*.id[0] # api://azbuilder/Builder.Default
      type = "Scope"
    }

  }

  required_resource_access {
    resource_app_id =  "00000003-0000-0000-c000-000000000000" # Microsoft Graph 

    resource_access {
      id   =  "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" #  Microsoft Graph offline_access
      type = "Scope"
    }

    resource_access {
      id   =  "e1fe6dd8-ba31-4d61-89e7-88639da4683d" #  Microsoft Graph User.Read
      type = "Scope"
    }

    resource_access {
      id   =  "37f7f235-527c-4136-accd-4a02d197296e" #  Microsoft Graph openid
      type = "Scope"
    }

    resource_access {
      id   =  "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0" #  Microsoft Graph email
      type = "Scope"
    }

    resource_access {
      id   =  "14dad69e-099b-42c9-810b-d002981feec1" #  Microsoft Graph profile
      type = "Scope"
    }

    resource_access {
      id   =  "df021288-bdef-4463-88db-98f22de89214" #  Microsoft Graph User.Read.All
      type = "Role"
    }

    resource_access {
      id   =  "5b567255-7703-4780-807c-7be8301ae99b" #  Microsoft Graph Group.Read.All
      type = "Role"
    }

    resource_access {
      id   =  "98830695-27a2-44f7-8c18-0c3ebc9698f6" #  Microsoft Graph GroupMember.Read.All
      type = "Role"
    }

    resource_access {
      id   =  "9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30" #  Microsoft Graph Application.Read.All
      type = "Role"
    }

  }

  single_page_application {
    redirect_uris = local.app_redirect_uri
  }

  optional_claims {
    id_token {
      name                  = "email"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "family_name"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "given_name"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "preferred_username"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "groups"
      essential             = false
      additional_properties = []
    }

    access_token {
      name                  = "groups"
      essential             = false
      additional_properties = []
    }

    saml2_token {
      name                  = "groups"
      essential             = false
      additional_properties = []
    }
  }

}


resource "azuread_application" "terrakube_cli" {
  display_name     = local.app_name_cli
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
  fallback_public_client_enabled = true

  required_resource_access {
    resource_app_id =  azuread_application.terrakube_base.application_id 

    resource_access {
      id   =  azuread_application.terrakube_base.app_role.*.id[0] # Builder.Application.Default
      type = "Role"
    }

    resource_access {
      id   =  azuread_application.terrakube_base.api.*.oauth2_permission_scope[0].*.id[0] # api://azbuilder/Builder.Default
      type = "Scope"
    }

  }

  public_client {
    redirect_uris = ["https://localhost:10000/login", "https://localhost:10001/login"]
  }

  optional_claims {
    id_token {
      name                  = "email"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "family_name"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "given_name"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "preferred_username"
      essential             = false
      additional_properties = []
    }

    id_token {
      name                  = "groups"
      essential             = false
      additional_properties = []
    }

    access_token {
      name                  = "groups"
      essential             = false
      additional_properties = []
    }

    saml2_token {
      name                  = "groups"
      essential             = false
      additional_properties = []
    }
  }

}

resource "azuread_application_password" "terrakube_api_password" {
  application_object_id = azuread_application.terrakube_api.object_id
  end_date_relative = "4380h" //six months
}