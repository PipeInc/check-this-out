#!/usr/bin/env bash
BUCKET=$1 # bucket name to sync with

AWSCLI=$(which aws) # Locate awscli bin
if [ $? != 0 ]; then 
    logger -p3 -s "AWSCLI binary not found. Please install and try again."
    exit 1
fi
# Check for the required bucket name
if [ -z $1 ]; then
    logger -p3 -s "Bucket name required. Usage: ./`basename $0` my-bucket"
    exit 1
fi
# Check for aws region
if [ -z $AWS_DEFAULT_REGION ]; then
    export AWS_DEFAULT_REGION="us-east-1"
fi
# Check for aws profile
if [ -z $AWS_PROFILE ]; then
    export AWS_PROFILE="default"
fi

# Use awscli to sync file with remote s3 bucket
${AWSCLI} s3 sync --profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} html/ s3://${BUCKET}/
if [ $? == 0 ]; then 
    logger -p6 -s "Successfully deployed to bucket $1 in $AWS_DEFAULT_REGION"
else
    logger -p3 -s "Error to deploy to bucket $1 in $AWS_DEFAULT_REGION"
fi