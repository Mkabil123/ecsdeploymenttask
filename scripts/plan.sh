#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if an environment is provided as an argument
if [ -z "$1" ]; then
  echo "No environment specified. Usage: ./plan.sh <environment>"
  exit 1
fi

ENVIRONMENT=$1
DIR="environments/${ENVIRONMENT}"

# Navigate to the environment directory
cd $DIR

# Initialize Terraform (if not already initialized)
echo "Initializing Terraform for $ENVIRONMENT environment..."
terraform init -input=false

# Generate a Terraform plan and save it to a file
PLAN_NAME="plan.tfplan"
echo "Generating Terraform plan for $ENVIRONMENT environment..."
terraform plan -input=false -out=${PLAN_NAME}

echo "Terraform plan for $ENVIRONMENT environment has been saved to ${DIR}/${PLAN_NAME}"
