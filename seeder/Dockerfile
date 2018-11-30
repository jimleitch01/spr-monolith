# 
FROM maven:3.3-jdk-8 

COPY pom.xml /tmp/pom.xml

RUN mvn -f /tmp/pom.xml -B -s /usr/share/maven/ref/settings-docker.xml dependency:resolve

RUN mkdir code

COPY . /code

WORKDIR /code

RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml test

