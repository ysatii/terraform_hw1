# Домашнее задание к занятию «Введение в Terraform» - Мельник Юрий Александрович

### Цели задания

1. Установить и настроить Terrafrom.
2. Научиться использовать готовый код.

------

### Чек-лист готовности к домашнему заданию

1. Скачайте и установите **Terraform** версии >=1.8.4 . Приложите скриншот вывода команды ```terraform --version```.
2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории **01/src**.
3. Убедитесь, что в вашей ОС установлен docker.

------


### готовоность к выполнению домашнего задания
1. Terraform установлен  
 ![рис 1](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_1.jpg)

2. Репозиторий скачан  
 ![рис 2](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_2.jpg)

3. Docker установлен  
 ![рис 3](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_3.jpg)


### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. Репозиторий с ссылкой на зеркало для установки и настройки Terraform: [ссылка](https://github.com/netology-code/devops-materials).
2. Установка docker: [ссылка](https://docs.docker.com/engine/install/ubuntu/). 
------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)
3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.
6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.
8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )


------

### Решение 1
1. Перейдем в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачаем все необходимые зависимости, использованные в проекте. 
 ![рис 4](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_4.jpg)  

2. Изучим содержимое .gitignore*
 ![рис 5](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_5.jpg)

**/.terraform/*
    Исключает все файлы и папки, находящиеся в любом каталоге .terraform.
    Каталог .terraform создаётся Terraform для хранения провайдеров, модуля и других временных данных, которые не должны попадать в репозиторий.

!.terraform*
    Исключает все файлы или каталоги, названия которых начинаются с .terraform.
    Например: .terraform.lock.hcl или .terraform_backup.

!.terraformrc
    Делает исключение для файла .terraformrc.
    Этот файл обычно используется для пользовательских настроек Terraform и может быть полезен для совместного использования, но его включение в репозиторий нужно учитывать осторожно, так как он может содержать конфиденциальные данные.

*.tfstate и *.tfstate.*
    Исключает файлы состояния Terraform:
        terraform.tfstate: основной файл состояния, который содержит текущую конфигурацию инфраструктуры.
        terraform.tfstate.backup или любые другие версии с суффиксом (например, .tfstate.12345).
    Эти файлы важны для работы Terraform, но их нельзя загружать в репозиторий, так как они могут содержать чувствительные данные (например, IP-адреса, токены доступа и т. д.).

Согласно этому .gitignore, для хранения личной и секретной информации допустимо использовать файл:
personal.auto.tfvars

3. Выполним код проекта. Найдем  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.  
 ![рис 6](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_6.jpg)  
 ![рис 7](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_7.jpg)  
 ![рис 8](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_8.jpg)  
```
"result": "8POGskoI6SaZr4yZ"
```  

4. Раскомментируем блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.  
 ![рис 9](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_9.jpg)   
ошибка указывает что имя контейнера не может начинаться с цифры  

ошибка исправлена запускаем валидацию еще раз 
 ![рис 10](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_10.jpg)  

 
 ![рис 11](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_11.jpg)  
  снова Ошибка, указывает что 
строка 24: resource "docker_image" должен иметь два параметра имя и тип  и имя 


исправляем запускаем снова 
опять ошибка,  31:   name  = "example_${random_password.random_string_FAKE.resulT}"
 ![рис 12](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_12.jpg)  

не правильно указан параметр "random_password.random_string_FAKE.resulT"
Исправляем  
 ![рис 13](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_13.jpg)  

 Успешно!  
 ![рис 14](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_14.jpg)  
 ![рис 15](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_15.jpg)  

5. Выполним код. В качестве ответа приложим: исправленный фрагмент кода и вывод команды ```docker ps```.  
 ![рис 16](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_16.jpg)  
 ![рис 17](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_17.jpg)  
 ![рис 18](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_18.jpg)  
 

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 

### Задание 2*

1. Создайте в облаке ВМ. Сделайте это через web-консоль, чтобы не слить по незнанию токен от облака в github(это тема следующей лекции). Если хотите - попробуйте сделать это через terraform, прочитав документацию yandex cloud. Используйте файл ```personal.auto.tfvars``` и гитигнор или иной, безопасный способ передачи токена!
2. Подключитесь к ВМ по ssh и установите стек docker.
3. Найдите в документации docker provider способ настроить подключение terraform на вашей рабочей станции к remote docker context вашей ВМ через ssh.
4. Используя terraform и  remote docker context, скачайте и запустите на вашей ВМ контейнер ```mysql:8``` на порту ```127.0.0.1:3306```, передайте ENV-переменные. Сгенерируйте разные пароли через random_password и передайте их в контейнер, используя интерполяцию из примера с nginx.(```name  = "example_${random_password.random_string.result}"```  , двойные кавычки и фигурные скобки обязательны!) 
```
    environment:
      - "MYSQL_ROOT_PASSWORD=${...}"
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - "MYSQL_PASSWORD=${...}"
      - MYSQL_ROOT_HOST="%"
```

6. Зайдите на вашу ВМ , подключитесь к контейнеру и проверьте наличие секретных env-переменных с помощью команды ```env```. Запишите ваш финальный код в репозиторий.


### Решение  2*
Машина создана! используем образ Ubuntu 24.04 LTS
 установим и настроем docker с помощью скрипта 
```
#!/bin/bash

# Проверяем, выполняется ли скрипт с правами root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт с правами root (sudo)."
  exit 1
fi

# Обновляем систему
echo "Обновляем списки пакетов..."
apt-get update -y

# Устанавливаем необходимые пакеты
echo "Устанавливаем необходимые зависимости..."
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Добавляем GPG-ключ Docker
echo "Добавляем ключ Docker GPG..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Добавляем репозиторий Docker
echo "Добавляем Docker-репозиторий..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем списки пакетов
echo "Обновляем списки пакетов (после добавления репозитория)..."
apt-get update -y

# Устанавливаем Docker
echo "Устанавливаем Docker CE, CLI и контейнерный runtime..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Проверяем установку
echo "Проверяем версию Docker..."
docker --version

# Устанавливаем автозапуск Docker
echo "Включаем автозапуск Docker..."
systemctl enable docker
systemctl start docker

echo "Установка Docker завершена!"

echo "Добавляем пользователя в группу Docker и перезаспукаем сервис Docker"
sudo usermod -aG docker lamer

# Путь к файлу конфигурации
SERVICE_FILE="/lib/systemd/system/docker.service"

# Проверяем, существует ли файл
if [ ! -f "$SERVICE_FILE" ]; then
  echo "Ошибка: Файл $SERVICE_FILE не найден."
  exit 1
fi

# Замена строки в файле
sed -i 's|ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock|ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock|' "$SERVICE_FILE"

# Перезапуск systemd и Docker
echo "Перезапуск systemd..."
systemctl daemon-reload

echo "Перезапуск Docker..."
systemctl restart docker

# Проверка статуса Docker
if systemctl is-active --quiet docker; then
  echo "Docker успешно перезапущен."
else
  echo "Ошибка: Docker не удалось перезапустить."
  exit 1
fi
```

Используем скрпит терраформ
```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }
  }
}

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

provider "docker" {
  #host = "tcp://89.169.136.224:2375"
  host = "ssh://lamer@89.169.136.224"
  ssh_opts = ["-i", "~/.ssh/id_ed25519", "-o", "StrictHostKeyChecking=no"]
  
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx_container" {
  image = docker_image.nginx.name
  name  = "example_${random_password.random_string.result}"
  ports {
    internal = 80
    external = 80
  }
}
# Генерация паролей
resource "random_password" "mysql_root_password" {
  length  = 16
  special = false
}

resource "random_password" "mysql_user_password" {
  length  = 16
  special = false
}

# Загрузка образа MySQL
resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = false
}

# Запуск контейнера MySQL
resource "docker_container" "mysql" {
  image = docker_image.mysql.name
  name  = "mysql_container"

  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]
}

output "mysql_root_password" {
  value = random_password.mysql_root_password.result
  sensitive = true
}

output "mysql_user_password" {
  value = random_password.mysql_user_password.result
  sensitive = true
}
```




### Задание 3*
1. Установите [opentofu](https://opentofu.org/)(fork terraform с лицензией Mozilla Public License, version 2.0) любой версии
2. Попробуйте выполнить тот же код с помощью ```tofu apply```, а не terraform apply.
------

### Правила приёма работы

Домашняя работа оформляется в отдельном GitHub-репозитории в файле README.md.   
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 

