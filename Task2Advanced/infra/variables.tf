# Обязательные переменные (передаются через секреты)
variable "subnet_id" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "yandex_cloud_id" {
  type = string
}

variable "yandex_folder_id" {
  type = string
}

variable "service_account_key_file" {
  type = string
}

# Необязательные переменные (со значениями по умолчанию)
variable "vm_name" {
  type    = string
  default = "dev-ubuntu-vm"
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 4
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}