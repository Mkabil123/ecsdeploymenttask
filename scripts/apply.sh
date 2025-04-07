#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if an environment is provided as an argument
if [ -z "$1" ]; then
  echo "No environment specified. Usage: ./apply.sh <environment>"
  exit 1
fi

ENVIRONMENT=$1
DIR="environments/${ENVIRONMENT}"

# Navigate to the environment directory
cd $DIR

# Apply the Terraform plan
PLAN_NAME="plan.tfplan"
echo "Applying Terraform plan for $ENVIRONMENT environment..."
terraform apply -input=false ${PLAN_NAME}

echo "Terraform apply for $ENVIRONMENT environment completed."
