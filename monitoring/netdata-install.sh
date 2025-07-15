#!/bin/bash
# Из Настройка Netdata на своем сервере.md

apt install -y netdata
sed -i 's/bind to = 127.0.0.1/bind to = 0.0.0.0/g' /etc/netdata/netdata.conf
systemctl restart netdata

