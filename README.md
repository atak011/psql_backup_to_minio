# PostgreSQL Backup to MinIO

This script automates the process of backing up a PostgreSQL database and uploading the backup to MinIO using the MinIO Client (`mc`). It's useful for automating database backup tasks and securely storing backups in an S3-compatible storage service.

## Features

- Creates a timestamped PostgreSQL database backup.
- Uploads the backup file to a specified MinIO bucket.
- Cleans up temporary backup files after successful upload.

## Requirements

- **PostgreSQL** installed and accessible.
- **MinIO Client (`mc`)** installed. [Installation Guide](https://min.io/docs/minio/linux/reference/minio-mc.html)
- A MinIO server or S3-compatible storage service configured.

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/<your-username>/postgresql-backup-to-minio.git
   cd postgresql-backup-to-minio
