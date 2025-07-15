#!/bin/bash
# Из GL.iNet Router Backup Guide.md

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/tmp/backup_$DATE"
mkdir -p $BACKUP_DIR
cp -r /etc/xray $BACKUP_DIR
tar -czf /tmp/backup_$DATE.tar.gz -C /tmp backup_$DATE
rm -rf $BACKUP_DIR
echo "Бэкап создан!"
