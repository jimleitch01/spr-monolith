FROM maven:3.3-jdk-8 AS builder
#FROM testrigregistry.azurecr.io/spr-monolith:seeder
COPY . . 
RUN ./mvnw install 

#FROM openjdk:8-jre 
