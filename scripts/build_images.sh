#!/bin/bash

resource_group="ash-master-rg"
rest_app_image_name="petclinic-rest"
frontend_app_image_name="petclinic-frontend"
database_app_image_name="petclinic-database"

packer build -var "resource_group=$resource_group" -var "image_name=$frontend_app_image_name" --force ../resources/frontend/petclinic-frontend-packer-template.json

packer build -var "resource_group=$resource_group" -var "image_name=$database_app_image_name" --force ../resources/db/petclinic-db-packer-template.json

git clone https://github.com/spring-petclinic/spring-petclinic-rest.git
cp -r ../resources/rest/application.properties spring-petclinic-rest/src/main/resources/application.properties
cp -r ../resources/rest/application-postgresql.properties spring-petclinic-rest/src/main/resources/application-postgresql.properties
cd spring-petclinic-rest && ./mvnw package
cd ..
cp -r spring-petclinic-rest/target/spring-petclinic-rest-2.4.2.jar ../resources/rest/

packer build -var "resource_group=$resource_group" -var "image_name=$rest_app_image_name" --force ../resources/rest/petclinic-rest-packer-template.json
rm -rf spring-petclinic-rest


