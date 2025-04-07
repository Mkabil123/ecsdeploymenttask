# ROR DEPLOYMENT
# AWS Terraform Infrastructure

This repository contains the Terraform configurations to manage infrastructure across different environments.The project is structured with reusable modules to promote consistency and efficiency across the infrastructure.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Environment Setup](#environment-setup)
- [Working with Modules](#working-with-modules)
- [Scripts](#scripts)

## Prerequisites

Before you begin, ensure that you have the following prerequisites in place:

### 1. AWS Account
You need an AWS account with sufficient permissions to provision resources (e.g., EC2, S3, RDS, ECS). Ensure you have access to your **AWS Access Key ID** and **AWS Secret Access Key** with Administrator access.


### 2. AWS CLI
Install the AWS Command Line Interface (CLI):
- [AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

### 3. Docker
Install Docker in your Machine:
- [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
- [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
- [Docker for Linux](https://docs.docker.com/engine/install/)

### 3. Terraform
Install Terraform in your Machine:
- [Terraform Installation](https://learn.hashicorp.com/tutorials/terraform/install-cli)


## Setting up Different Environments

To create different environments, follow these steps:
1. Copy the `dev` folder inside the `environments` folder and paste it into the same `environments` folder.
2. Change the folder name to the desired environment name (e.g., `qa`, `prod`).
3. Update the environment name and region in the `terraform.tfvars` file.
4. Change the region and S3 backend key in the `backend.tf` file.


## Running the Scripts
**Navigate to the project directory:**
1. **Run the initialization script:**
    ```sh
    ./scripts/init.sh <ENVIRONMENT FOLDER NAME>
    ```

2. **Run the planning script:**
    ```sh
    ./scripts/plan.sh <ENVIRONMENT FOLDER NAME>
    ```

3. **Run the apply script:**
    ```sh
    ./scripts/apply.sh <ENVIRONMENT FOLDER NAME>
    ```
4. **Run the destroy script:**
    ```sh
    ./scripts/apply.sh <ENVIRONMENT FOLDER NAME>
    ```   