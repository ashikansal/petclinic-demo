# Deploy Petclinic 3 tier application

## 1) Export Credentials, to deploy resources on Azure
```
export ARM_CLIENT_ID=xxxxxxxxxx
export ARM_CLIENT_SECRET=xxxxxxxxxx
export ARM_SUBSCRIPTION_ID=xxxxxxxxxx
export ARM_TENANT_ID=xxxxxxxxxx
```

## 2) Setup base resources
### It involves setting up Master Resource Group and Storage Account for storing images and tfstate

cd scripts && ./build_base_infra.sh

## 3) Create Base Packer Images
### It involves creating base images for frontend, rest and Db

cd scripts && ./build_images.sh

## 4) Deploy Petclinic Application

cd tf_code && terraform apply -var-file config/dev.tfvars --auto-approve


