# FROM maven:3.3-jdk-8 
#FROM cloudbees/java-build-tools:latest 

FROM jenkins/ssh-slave:latest

RUN apt-get update && apt-get install -y maven


RUN mkdir -p seed/maven/ref/repository

WORKDIR /home/jenkins/seed

#RUN cat /usr/share/maven/ref/settings-docker.xml

COPY pom.xml /tmp/pom.xml

COPY seeder/settings.xml seed/maven/ref/settings-docker.xml

RUN mvn -f /tmp/pom.xml -B -s seed/maven/ref/settings-docker.xml dependency:resolve

COPY . .

RUN mvn -B -s seed/maven/ref/settings-docker.xml test

EXPOSE 22

ENTRYPOINT ["setup-sshd"]