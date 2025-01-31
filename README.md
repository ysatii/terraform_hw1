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
 
6. Замениv имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve.
 ![рис 31](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_31.jpg)  
-auto-approve опасен тем что выполнит скрипт автоматически что может привести к необратимым последствиям в случаии ошибок!
такая опция может быть необходима для систем  CI/CD где действия нужноь выполнять автоматичеси!  

7. Удалим  объекты созданныые terraform 
 ![рис 32](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_32.jpg)  
 ![рис 33](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_33.jpg)  

8. Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ, а затем ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ строчкой из документации terraform провайдера docker. (ищите в классификаторе resource docker_image )

потому что использовали параметр keep_locally = true при создании образа.  

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
 ![рис 23](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_23.jpg)  
 установим и настроем docker с помощью скрипта [sh.sh](https://github.com/ysatii/terraform_hw1/blob/main/sh.sh) 
 проверим версию terraform
 ![рис 24](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_24.jpg)  

Запустим скрипт terraform из папки docker-provaider командой  
```
terraform apply
```
скрипт выполнен успешно !
 ![рис 25](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_25.jpg)  


Проверим список работающих контейнеров и загруженных образов
 ![рис 26](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_26.jpg)  
 ![рис 27](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_27.jpg)  

подклюючимся  к контейнеру и проверим переенные окружения  
 ![рис 28](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_28.jpg) 

удалим объекты terraform, проверим наличие образов и работающх контейнеров
 ![рис 29](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_29.jpg) 
 ![рис 30](https://github.com/ysatii/terraform_hw1/blob/main/img/ter_30.jpg)  

все контейнеры и образы уничтожены






Используем скрпит [терраформ](https://github.com/ysatii/terraform_hw1/blob/main/docker-provaider/main.tf)
для скачивания образов и создания конфтейнеров на docker сервере






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

