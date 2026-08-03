# Задание 1. Модульная инфраструктура для нескольких сред

Модуль принимает следующие параметры:
- `vm_name` — имя ВМ.
- `cores` — количество ядер vCPU.
- `memory` — объем RAM (ГБ).
- `disk_size` — размер загрузочного диска (ГБ).
- `subnet_id` — id подсети Yandex Cloud.
- `ssh_public_key_path` — путь к публичному SSH ключу на локальной машине.

Создан файл с переменными для установки параметров окружений - [variables.tf] (https://github.com/tammaco/architecture-future_2_0/Task1Advanced/modules/vm/variables.tf).
Добавлен файл создания ресурсов - [main.tf] (https://github.com/tammaco/architecture-future_2_0/Task1Advanced/modules/vm/main.tf) и файл для вывода результатов работы модуля - [outputs.tf] (https://github.com/tammaco/architecture-future_2_0/Task1Advanced/modules/vm/outputs.tf).

Добавлены конфигурации для каждого окружения в папки `envs/dev/`, `envs/stage/`, `envs/prod/`.

Для работы в корневой папке проекта должен лежать файл `key.json` (сервисный аккаунт Yandex Cloud). 
Запуск выполняется **внутри папки нужного окружения**:


1. **dev**

```bash
cd envs/dev
terraform init
terraform apply -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```


2. **stage**

```bash
cd ../stage
terraform init
terraform apply -var-file="stage.tfvars"
terraform apply -var-file="stage.tfvars"
```

3. **prod**

```bash
cd ../prod
terraform init
terraform apply -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

Все параметры для конкретного окружения задаются в файлах dev.tfvars, stage.tfvars, prod.tfvars соответственно.
Пример для dev-среды:

```
service_account_key_file = "key.json"
yandex_cloud_id          = "b1..." 
yandex_folder_id         = "b1..." 

zone      = "ru-central1-a"
vm_name   = "dev-ubuntu-vm"
cores     = 2
memory    = 4
disk_size = 10
subnet_id = "e9..." 
ssh_key_path    = "/home/lenovo/.ssh/id_rsa.pub"
```

Скрин созданного [dev-окружения] (https://github.com/tammaco/architecture-future_2_0/Task1Advanced/screenshots/dev-architecture-future-vm.png) и [файла состояния] (https://github.com/tammaco/architecture-future_2_0/Task1Advanced/screenshots/dev_output.png).