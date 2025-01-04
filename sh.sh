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