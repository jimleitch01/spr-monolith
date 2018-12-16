FROM maven:3.3-jdk-8 AS builder
#FROM testrigregistry.azurecr.io/spr-monolith:seed as builder

WORKDIR /code

COPY . . 

RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml -DskipTests install



FROM openjdk:8-jre-alpine

RUN apk --no-cache add ca-certificates

RUN mkdir /app

WORKDIR /app

COPY --from=builder /code/target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar ./app.jar

CMD ["java", "-jar", "app.jar"] 