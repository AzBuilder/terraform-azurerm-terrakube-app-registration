
variable "app_name" {
  type    = string
  default = "terrakube"
}

variable "app_redirect_uri" {
  type    = string
  description = "Application redirect URI. Example: https://ui.terrakube.docker.internal"
}