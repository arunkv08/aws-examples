#!/usr/bin/env bash

# Check for bucket name
if [ -z "$1" ]; then
    echo "There needs to be a bucket name. e.g. ./s3_buckets.sh arun.aws.s3.bucket.1978.1"
    exit 1
fi

BUCKET_NAME=$1
echo -e "\n******** ${BUCKET_NAME} ***********"  

echo -e "\nls buckets (before delete)"  
aws s3 ls --region ap-south-1

echo -e "\ndelete bucket"  
aws s3 rm s3://${BUCKET_NAME} --recursive
aws s3api delete-bucket --bucket ${BUCKET_NAME} --region ap-south-1

echo -e "\nls buckets (after delete)"  
aws s3 ls --region ap-south-1

echo -e "\ncreate-bucket ${BUCKET_NAME}"  
aws s3api create-bucket \
--bucket $BUCKET_NAME \
--region ap-south-1 \
--create-bucket-configuration LocationConstraint=ap-south-1 \
--query Location \
--output text

echo -e "\nls buckets (after create)"  
aws s3 ls --region ap-south-1

echo -e "\n"
