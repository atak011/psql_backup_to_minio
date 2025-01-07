# PostgreSQL Backup to MinIO

A Bash script to automate the backup of a PostgreSQL database and upload the backup to MinIO using the MinIO Client (`mc`). This script simplifies database backup tasks and ensures secure storage in an S3-compatible bucket.

## Features

- Automatically creates a timestamped PostgreSQL database backup.
- Uploads the backup to a specified MinIO bucket.
- Cleans up local backup files after successful upload.

## Requirements

- PostgreSQL installed and accessible.
- MinIO Client (`mc`) installed. [Installation Guide](https://min.io/docs/minio/linux/reference/minio-mc.html)
- A MinIO server or S3-compatible storage service.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/atak011/postgresql-backup-to-minio.git
   cd postgresql-backup-to-minio
Make the script executable:

bash
Kodu kopyala
chmod +x backup_to_minio.sh
Update the script with your configurations:

PostgreSQL:
PG_HOST, PG_PORT, PG_USER, PG_PASSWORD, PG_DATABASE.
MinIO:
MINIO_ALIAS, MINIO_BUCKET, <MINIO_ENDPOINT>, <MINIO_ACCESS_KEY>, <MINIO_SECRET_KEY>.
Run the script:

bash
Kodu kopyala
./backup_to_minio.sh
Verify the backup in your MinIO bucket.

Example MinIO Configuration
Set the MinIO alias using the following command:

bash
Kodu kopyala
mc alias set minio http://<MINIO_ENDPOINT> <MINIO_ACCESS_KEY> <MINIO_SECRET_KEY>
Notes
Ensure pg_dump is accessible in your system's PATH.
The script deletes local backup files after uploading them to MinIO. If you want to retain the local files, comment out the rm -f $BACKUP_FILE line in the script.
Test the script in a staging environment before using it in production.
License
This project is licensed under the MIT License. See the LICENSE file for details.
