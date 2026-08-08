output "vm_id" {
  description = "ID созданной ВМ"
  value       = yandex_compute_instance.this.id
}

output "vm_name" {
  value       = yandex_compute_instance.this.name
}

output "vm_external_ip" {
  value       = yandex_compute_instance.this.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  value       = yandex_compute_instance.this.network_interface[0].ip_address
}

output "boot_disk_id" {
  value       = module.vm.boot_disk_id
}