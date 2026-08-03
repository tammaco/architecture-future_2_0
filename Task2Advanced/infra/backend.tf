terraform {
  backend "http" {
    address  = "https://storage.yandexcloud.net/architecture-future-state-bucket/task2/terraform.tfstate"
    update_method = "PUT"
    lock_address  = "https://storage.yandexcloud.net/architecture-future-state-bucket/task2/terraform.tfstate.lock"
    unlock_method = "DELETE"
    lock_method   = "PUT"
  }
}