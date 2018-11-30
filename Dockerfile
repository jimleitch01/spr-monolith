#FROM maven:3.3-jdk-8 AS builder
FROM testrigregistry.azurecr.io/spr-monolith:seed

WORKDIR /code

COPY . . 

RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml test

# RUN mv /usr/share/maven/ref/repository/ /root/.m2/

# RUN mvn -s /usr/share/maven/ref/settings-docker.xml install 

#FROM openjdk:8-jre 
