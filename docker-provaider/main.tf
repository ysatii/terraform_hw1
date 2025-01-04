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
  #host = "tcp://84.201.144.127:2375"
  host = "ssh://84.201.144.127.224"
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