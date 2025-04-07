#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if an environment is provided as an argument
if [ -z "$1" ]; then
  echo "No environment specified. Usage: ./init.sh <environment>"
  exit 1
fi

ENVIRONMENT=$1
DIR="environments/${ENVIRONMENT}"

# Navigate to the environment directory
cd $DIR

# Initialize Terraform
echo "Initializing Terraform for $ENVIRONMENT environment..."
terraform init -input=false

echo "Terraform initialization for $ENVIRONMENT environment completed."
