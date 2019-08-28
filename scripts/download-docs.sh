#!/bin/bash
set -ex

# Load pipeline env vars and proxy env vars.
source /etc/profile.d/deployment_information.sh
source /etc/profile.d/proxy.sh

echo "Downloading core-automation user-guide and developer-guide to /var/www/html"

# fix the BRANCH to be "master" since we are always pulling updates from master branch from core-automation and ccoe-workbook build
export LOCAL_BRANCH='master'

# user-guide
aws s3 cp s3://abc-core-automation-ap-southeast-1/files/shared/ccoe/$LOCAL_BRANCH/user-guide.tar.gz /tmp
sudo tar -xzf /tmp/user-guide.tar.gz -C /var/www/html/user-guide

# developer-guide
aws s3 cp s3://abc-core-automation-ap-southeast-1/files/shared/ccoe/$LOCAL_BRANCH/developer-guide.tar.gz /tmp
sudo tar -xzf /tmp/developer-guide.tar.gz -C /var/www/html/developer-guide

# workbook
aws s3 cp s3://sia-core-automation-ap-southeast-1/files/shared/ccoe/$LOCAL_BRANCH/workbook.tar.gz /tmp
sudo tar -xzf /tmp/workbook.tar.gz -C /var/www/html/workbook

# We're running on the box via cron.
sudo chown -R apache:apache /var/www/html
sudo chmod -R 0755 /var/www/html
