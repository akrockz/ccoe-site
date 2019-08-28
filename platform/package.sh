#!/bin/bash
set -ex

echo "ccoe-site package.sh script"

# setup
mkdir -p $REPO_DIR/site/public
rm -rf $REPO_DIR/site/public/*
rm -rf $FILES_DIR/*

# compile hugo
cd $REPO_DIR/site
hugo version
hugo

# spit out the build number, as a debug method.
echo $BUILD > $REPO_DIR/site/public/build.txt

# Download the latest core-automation user-guides from S3, extract both into public folder.
# TODO Move to ansible, so we can call via cron?

# fix the BRANCH to be "master" since we are always pulling updates from master branch from core-automation and ccoe-workbook build
export LOCAL_BRANCH='master'

mkdir $REPO_DIR/site/public/user-guide
aws s3 cp s3://abc-core-automation-ap-southeast-1/files/shared/ccoe/$LOCAL_BRANCH/user-guide.tar.gz /tmp
tar -xzf /tmp/user-guide.tar.gz -C $REPO_DIR/site/public/user-guide

mkdir $REPO_DIR/site/public/developer-guide
aws s3 cp s3://abc-core-automation-ap-southeast-1/files/shared/ccoe/$LOCAL_BRANCH/developer-guide.tar.gz /tmp
tar -xzf /tmp/developer-guide.tar.gz -C $REPO_DIR/site/public/developer-guide

mkdir $REPO_DIR/site/public/workbook
aws s3 cp s3://sia-core-automation-ap-southeast-1/files/shared/ccoe/$LOCAL_BRANCH/workbook.tar.gz /tmp
tar -xzf /tmp/workbook.tar.gz -C $REPO_DIR/site/public/workbook

# package up zip
cd $REPO_DIR/site/public
ls -lah .
tar -czvf $FILES_DIR/public.tar.gz .

# package up scripts
cd $REPO_DIR/scripts
ls -lah .
tar -czvf $FILES_DIR/scripts.tar.gz .

echo "done"
