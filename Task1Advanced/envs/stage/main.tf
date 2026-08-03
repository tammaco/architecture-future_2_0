module "vm" {
  source   = "../../modules/vm"

  vm_name          = var.vm_name
  cores            = var.cores
  memory           = var.memory
  disk_size        = var.disk_size
  subnet_id        = var.subnet_id
  ssh_public_key_path = "~/.ssh/id_rsa.pub" 

  yandex_cloud_id      = var.yandex_cloud_id
  yandex_folder_id     = var.yandex_folder_id
  service_account_key_file = var.service_account_key_file
}