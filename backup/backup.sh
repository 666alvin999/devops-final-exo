#!/bin/bash

DATE=$(date +'%Y%m%d_%H%M%S')
BACKUP_DIR=/backup
MAX_BACKUPS=5
DB_HOST=db
DB_USER=root
DB_PASS=$(cat /run/secrets/mysql_root_password)
DB_NAME=prestashop

mysqldump -h $DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME | gzip > $BACKUP_DIR/db_backup_$DATE.sql.gz

ls -t $BACKUP_DIR/db_backup_*.sql.gz | tail -n +$((MAX_BACKUPS+1)) | xargs -r rm --
