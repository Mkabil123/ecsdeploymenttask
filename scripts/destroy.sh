#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if an environment is provided as an argument
if [ -z "$1" ]; then
  echo "No environment specified. Usage: ./destroy.sh <environment>"
  exit 1
fi

ENVIRONMENT=$1
DIR="environments/${ENVIRONMENT}"

# Navigate to the environment directory
cd $DIR

# Destroy the Terraform-managed infrastructure
echo "Destroying Terraform-managed infrastructure for $ENVIRONMENT environment..."
terraform destroy -input=false -auto-approve

echo "Terraform destroy for $ENVIRONMENT environment completed."
