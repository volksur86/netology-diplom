variable "yandex_token" {
  type      = string
  sensitive = true
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "web_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b"]
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "image_id" {
  type    = string
  default = "fd883rif8e2s2nqkskao" # Ubuntu Vanila 22.04 LTS
}
