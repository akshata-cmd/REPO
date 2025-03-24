#!/bin/bash

: << 'HELP'
This is a shell script to take backups.
It can also be used with cron.
HELP

set -e  # Stop on errors

source_dir="/home/ubuntu/scripts"
destination_dir="/home/ubuntu/backups"
log_file="/var/log/backup.log"

function create_backup {
    local source="$1"
    local destination="$2"
    
    if [[ ! -d "$source" ]]; then
        echo "Error: Source directory '$source' does not exist!" >&2
        exit 1
    fi

    if [[ ! -d "$destination" ]]; then
        echo "Creating destination directory: $destination"
        mkdir -p "$destination"
    fi

    timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
    backup_file="${destination}/backup_${timestamp}.zip"

    if zip -r "$backup_file" "$source"; then
        echo "✅ Backup completed successfully: $backup_file"
        echo "$(date) - Backup created: $backup_file" >> "$log_file"
    else
        echo "❌ Backup failed!" >&2
        exit 1
    fi
}

create_backup "$source_dir" "$destination_dir"
