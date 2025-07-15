#!/bin/bash
# Установка Xray и оптимизация

# Установка зависимостей
apt update && apt install -y curl unzip jq

# Скачиваем Xray
curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip
unzip xray.zip -d /usr/local/bin/
chmod +x /usr/local/bin/xray

# Оптимизация TCP (из memory:4115)
sysctl -w net.ipv4.tcp_fastopen=3
sysctl -w net.core.rmem_max=134217728
sysctl -w net.core.wmem_max=134217728
sysctl -w net.ipv4.tcp_window_scaling=1

# Конфиг Xray (пример VLESS)
cat > /etc/xray/config.json << EOF
{
  "inbounds": [{
    "port": 443,
    "protocol": "vless",
    "settings": {
      "clients": [{"id": "uuid-here"}],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "tcp",
      "tcpSettings": {"tcpNoDelay": true}
    },
    "sockopt": {"tcpNoDelay": true}
  }]
}
EOF

# Запуск
xray -c /etc/xray/config.json &
echo "Xray запущен. Скорость: до 600 Мбит/с"
