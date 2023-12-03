# selectel_create_multiple_servers
## Установить terraform и зайти в папку со скриптом
## Заполнить данные аккаунта Selectel
  domain_name = Домен вашего аккаунта
  tenant_id = ID проекта в который будут добавляться сервера
## Нужно создать сервисного пользователя с ролью Администратор проекта
  user_name   = Имя сервисного пользователя
  password    = Пароль сервисного пользователя
## Сгенерировать ssh ключ в Selectel
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCt9pOh2goCIpWI0sOgNlioJEe3eaQKtvQv+zDr54twEyjfWvfy02A6Nqlg2dIPkD4j3xa2KOXkpaw9PlEwkf0YlBR0QmLmnbT+2ntM2JehxTk5zbGRYtGk5IHof/HxAUMeZq31U2jvqvuS0k4Zy82Y9PSUNB60Mfgy9S7aQyhRB/AMswkJuDdLnCXNjrQa8Ez5uuhOj//LExaD57wenhVkILrRuWc53kZAVTjv9WHri23DEKS3qTm7BiltWanZ6AFpoJA0FN8702oBD6awxfNEdhEh3cY20af10LJfJU3UWPcI7z/4GseBN5p6UoT1T2MlhckgBifhtkALexjG1tNFO5+M4It9djKLydUDs4dnXMUAtA46YV4E5ea90x9qW5h9iCLs/81GUZufp7A3NZ/m3nn3Xoq6G/7d32KZ8L9WN6kv0Y89bieIURc2k/E7/X+kruIeJxlEawafs9ubo/BpplOA/ToxcW7pwdjvs4jbnRY64JE5Yrnql5qlPHSy8bx1sM7xKff2/p4V2Wnn1PSPws/U6VH7ZiCMp/ZyOOPP/Puq8c9/jxW3s2xCUFCa6HlX0RFEU//w403Fdr79P+iCIFhg2VOaFpwd1ZVXUrurBj0SplAtqHYCSG0j5/j+n6epEYouLnt5wZN0CdiVBhSb9bvlSmWnQ2YipZDXSXAO0Q== sporyshev.savelii@gmail.com" Это ключ ssh
}

## Настроить регион и зону в файле vars

## Настроить параметры сервера в main

resource "openstack_compute_flavor_v2" "flavor_server" {
  name      = "server-${random_string.random_name_server.result}"
  Оперативная память 
  ram       = "4096"
  Количество процессоров
  vcpus     = "4"
  Размер диска
  disk      = "5" 
  Публичный или приватный
  is_public = "false"
}
## Задать количество серверов в файле vars 

variable "replicas_count" {
  default = 10
}

## Запустить команду terraform init
## Запустить команду terraform plan
## Запустить команду terraform apply
