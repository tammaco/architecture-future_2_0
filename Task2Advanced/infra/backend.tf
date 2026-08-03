terraform {
  backend "s3" {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "architecture-future-state-bucket"
    region     = "us-east-1"
    key        = "task2/terraform.tfstate"
    
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}