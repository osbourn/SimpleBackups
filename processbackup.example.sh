#!/bin/bash
# processbackup.sh
# Should not be invoked manually
set -e
cd

backup_full_path="$1"
backup_filename=$(basename "${backup_full_path}")
bucket_name="mybucket"

echo "Uploading ${backup_full_path} to S3..."
aws s3 cp "${backup_full_path}" "s3://${bucket_name}/backups/${backup_filename}" --acl public-read > /dev/null
s3_url="https://${bucket_name}.s3.amazonaws.com/backups/${backup_filename}"
echo "Upload finished: ${s3_url}"

# Uncomment to post a message to a Discord webhook
# echo "Posting message to Discord webhook"
# webhook_url=https://discord.com/api/webhooks/986807931330789447/ngKkGXjJLBJBv0i1ANZOPUMTZ0dzqhPIkVzuNaD6yu3jzJubmiRxRTcaJMtndXsy7wPJ
# webhook_username="Server Backups"
# webhook_message="Backup with created at ${s3_url}"
# curl -X POST -H "Content-Type: application/json" -d "{\"username\": \"${webhook_username}\", \"content\":\"${webhook_message}\"}" "$webhook_url" 2> /dev/null
