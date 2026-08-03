variable "vm_name"      { type = string }
variable "cores"        { type = number }
variable "memory"       { type = number }
variable "disk_size"    { type = number }
variable "subnet_id"    { type = string }
variable "ssh_public_key_path" { type = string }
variable "zone"         { type = string }

variable "yandex_folder_id" { type = string }
variable "yandex_access_key" { type = string }
variable "yandex_secret_key" { type = string }
variable "service_account_key_file" { type = string }