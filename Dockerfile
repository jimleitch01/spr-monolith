FROM openjdk:8 AS builder
COPY . . 
RUN ./mvnw build 

FROM openjdk:8-jre 
