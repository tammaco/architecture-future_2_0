# Задание 2. Интеграция с CI/CD и удалённым хранением состояния

Перед запуском Terraform необходимо создать бакет в Yandex Cloud, который будет использоваться для хранения файла состояния (terraform.tfstate). После создания бакета и статических ключей (Access Key / Secret Key) их нужно добавить в GitHub Secrets.

1. Настройте бэкенда 

Для хранения состояния используется S3-совместимое хранилище Yandex Object Storage. Конфигурация бэкенда находится в файле infra/backend.tf и не содержит жестко заданных ключей — они передаются через переменные окружения.

```
terraform {
  backend "s3" {
    endpoint                    = "https://storage.yandexcloud.net"
    bucket                      = "architecture-future-state-bucket"
    region                      = "us-east-1"
    key                         = "task2/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    access_key = ""
    secret_key = ""
  }
}
```

2. Настройка CI/CD Pipeline (GitHub Actions)

Pipeline настроен в файле .github/workflows/terraform.yml и выполняет следующие шаги:

**init** — инициализация Terraform с удалённым бэкендом.

**plan** — создание плана изменений.

**apply** — применение плана. Этот шаг защищён ручным подтверждением (используется environment: production).

Все переменные передаются в контейнер с Terraform через переменные окружения (env).

3. Управление переменными
Проект использует два типа переменных:

3.1. Публичные переменные (передаются через vars в GitHub Actions)
Переменные с типовыми значениями, не являющиеся секретными, хранятся как Environment variables в настройках GitHub репозитория.

|Имя переменной|Значение по умолчанию|Назначение|
|-|-|-|
|TF_VAR_vm_name|dev-ubuntu-vm|Имя создаваемой виртуальной машины|
|TF_VAR_cores|2|Количество ядер CPU|
|TF_VAR_memory|4|Объём RAM в ГБ|
|TF_VAR_disk_size|10|Размер загрузочного диска в ГБ|
|TF_VAR_zone|ru-central1-a|Зона доступности Yandex Cloud|
|TF_VAR_ssh_public_key|-|Содержимое публичного SSH-ключа (передаётся через secrets)|

3.2. Секретные переменные (хранятся в GitHub Secrets)
Конфиденциальные данные, хранятся в зашифрованных секретах GitHub.

|Имя секрета|Назначение|
|-|-|
|AWS_ACCESS_KEY_ID|Статический ключ для доступа к Object Storage (бэкенд)|
AWS_SECRET_ACCESS_KEY	Секретный ключ для доступа к Object Storage|
|YC_CLOUD_ID|Идентификатор облака в Yandex Cloud|
|YC_FOLDER_ID|Идентификатор каталога (folder), в котором создаются ресурсы|
|TF_VAR_subnet_id|Идентификатор подсети для сетевого интерфейса ВМ|
|TF_VAR_service_account_key_file_path|Путь к файлу key.json или его содержимое для аутентификации провайдера|
|TF_VAR_ssh_public_key|Содержимое публичного SSH-ключа (строка, начинающаяся с ssh-rsa)|

4. Результаты

4.1. Локальная инициализация

Результат [plan](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/plan.png)

Результат [apply](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/apply.png)

Результат [в облаке](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/cloud.png)

4.2. CI/CD

Результат [githubactions](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/githubactions.png)

Результат [в облаке](https://github.com/tammaco/architecture-future_2_0/Task2Advanced/screenshots/cloud_cicd.png)