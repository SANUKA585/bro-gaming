#!/bin/bash

# Set non-interactive for timezone
export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Install tmate and expect
apt-get update
apt-get install -y tmate expect

# Start tmate in background
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# Print SSH and Web (read-write) session links
echo "SSH access:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
echo "Web access (read-write):"
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'

# Auto type to keep it alive
while true; do
    tmate -S /tmp/tmate.sock send-keys "echo alive && date" C-m
    sleep 300
done
