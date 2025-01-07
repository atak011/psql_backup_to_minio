#!/bin/bash

# PostgreSQL bilgileri
PG_HOST="localhost"
PG_PORT="5432"
PG_USER="postgres"
PG_PASSWORD="password"
PG_DATABASE="my_database"
BACKUP_DIR="/path/to/backup"
BACKUP_FILE="$BACKUP_DIR/$(date +%Y%m%d%H%M%S)_$PG_DATABASE.sql"

# MinIO bilgileri
MINIO_ALIAS="minio"
MINIO_BUCKET="my-backup-bucket"
MINIO_PATH="$MINIO_BUCKET/backups/$(basename $BACKUP_FILE)"

# PostgreSQL şifresini ayarla
export PGPASSWORD=$PG_PASSWORD

# Yedekleme işlemi
echo "Veritabanı yedeği alınıyor: $PG_DATABASE"
mkdir -p $BACKUP_DIR
pg_dump -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DATABASE -F c -f $BACKUP_FILE

if [ $? -ne 0 ]; then
    echo "PostgreSQL yedeği alınırken hata oluştu."
    exit 1
fi

echo "Yedek alındı: $BACKUP_FILE"

# MinIO'ya yükleme
echo "Yedek MinIO'ya yükleniyor: $MINIO_PATH"
mc alias set $MINIO_ALIAS http://<MINIO_ENDPOINT> <MINIO_ACCESS_KEY> <MINIO_SECRET_KEY>
mc cp $BACKUP_FILE $MINIO_ALIAS/$MINIO_PATH

if [ $? -ne 0 ]; then
    echo "MinIO'ya yükleme başarısız oldu."
    exit 1
fi

echo "Yedek MinIO'ya yüklendi: $MINIO_PATH"

# Geçici dosyaları temizleme (isteğe bağlı)
echo "Geçici yedek dosyası siliniyor: $BACKUP_FILE"
rm -f $BACKUP_FILE

echo "Yedekleme işlemi tamamlandı."
