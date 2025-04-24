#!/bin/bash

INSTANCE_ID=i-08d1bc472c8e7033b

ipv4_address=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

file_to_find="../frontend/.env.docker"

current_url=$(cat $file_to_find)

# Update the .env file if the IP address has changed
if [[ "$current_url" != "VITE_API_PATH=\"http://${ipv4_address}:30080\"" ]]; then
    if [ -f $file_to_find ]; then
        sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:30080\"|g" $file_to_find
    else
        echo "ERROR: File not found."
    fi
fi
