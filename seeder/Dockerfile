#FROM maven:3.3-jdk-8 
FROM cloudbees/jnlp-slave-with-java-build-tools:latest 

RUN mkdir code
WORKDIR /code

#RUN cat /usr/share/maven/ref/settings-docker.xml

RUN mkdir -p maven/ref/repository

COPY pom.xml /tmp/pom.xml

COPY seeder/settings.xml maven/ref/settings-docker.xml

RUN mvn -f /tmp/pom.xml -B -s maven/ref/settings-docker.xml dependency:resolve

COPY . /code

RUN mvn -B -s maven/ref/settings-docker.xml test

