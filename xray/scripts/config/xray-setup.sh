#!/bin/bash
# Из Vless.md + оптимизации из Xray Speed Optimization Guide.md

apt update && apt install -y curl unzip jq
curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip
unzip xray.zip -d /usr/local/bin/
chmod +x /usr/local/bin/xray

# Оптимизации
sysctl -w net.ipv4.tcp_fastopen=3
sysctl -w net.core.rmem_max=134217728
sysctl -w net.core.wmem_max=134217728
sysctl -w net.ipv4.tcp_window_scaling=1

# Конфиг (из Итоги настройки X-Ray Reality VPN.md)
cat > /etc/xray/config.json << EOF
{
  "log": {"loglevel": "warning", "error": "/var/log/xray/error.log"},
  "inbounds": [{"port": 443, "protocol": "vless", "settings": {"clients": [{"id": "46a83871-62f6-40b9-9220-0437aaf0b3f4", "flow": "xtls-rprx-vision"}], "decryption": "none"}, "streamSettings": {"network": "tcp", "security": "reality", "realitySettings": {"show": true, "dest": "www.whatsapp.com:443", "serverNames": ["www.whatsapp.com"], "xver": 0, "privateKey": "YEp885Cr0hx12J1TFvq8qXs-vCPUjGHjz2t5zc6EcXE", "shortIds": ["7c7f7a7b"]}}}],
  "outbounds": [{"protocol": "freedom", "tag": "direct"}]
}
EOF

xray -c /etc/xray/config.json &

