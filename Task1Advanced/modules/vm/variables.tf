variable "vm_name" {
  type        = string
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "cores" {
  type        = number
}

variable "memory" {
  type        = number
}

variable "disk_size" {
  type        = number
  default     = 10
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
}

variable "subnet_id" {
  type        = string
}

variable "ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "service_account_key_file" {
  type        = string
}

variable "yandex_cloud_id" {
  type        = string
}

variable "yandex_folder_id" {
  type        = string
}