# Задание 2. Интеграция с CI/CD и удалённым хранением состояния

Перед запуском Terraform необходимо создать бакет в Yandex Cloud, который будет использоваться для хранения файла состояния (`terraform.tfstate`).
После создания бакета и ключей (Access Key / Secret Key) их необходимо добавить в GitHub Secrets

1. Настройте Terraform-код с backend’ом с использованием S3-совместимого хранилища (minio, Yandex Object Storage, AWS S3).

Добавлен файл для бэкэнда:

```
terraform {
  backend "s3" {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "architecture-future-state-bucket"
    region     = "us-east-1"
    key        = "task2/terraform.tfstate"
    
    access_key = ""
    secret_key = ""
    
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
```

Ключи передаются через переменные окружения.

2. Pipeline с использованием GitHub Actions

**init** — инициализация Terraform

**plan** — создание плана изменений

**apply** — применение плана. Этот шаг защищён ручным подтверждением (environment: production)

Проект использует два типа переменных:

Публичные переменные (хранятся в Git)
Файл: infra/terraform.tfvars.public

```
hcl
vm_name   = "dev-ubuntu-vm"
cores     = 2
memory    = 4
disk_size = 10
zone      = "ru-central1-a"
```

Секретные переменные (хранятся в GitHub Secrets)
Передаются через блок env: и попадают в Terraform как переменные окружения.

|Имя секрета|Назначение|
|-|-|
|AWS_ACCESS_KEY_ID|Идентификатор ключа для S3-бэкенда|
|AWS_SECRET_ACCESS_KEY|Секретный ключ для S3-бэкенда|
|TF_VAR_yandex_folder_id|ID каталога для создания ВМ|
|TF_VAR_subnet_id|ID подсети для создания ВМ|
|TF_VAR_service_account_key_file|Путь к key.json или его содержимое|
|TF_VAR_ssh_public_key_path|Путь к SSH-ключу пользователя|


## Локальная инициализация

Результат [plan](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/plan.png)

Результат [apply](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/apply.png)

Результат [в облаке](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/cloud.png)