FROM maven:3.3-jdk-8 

COPY pom.xml /tmp/pom.xml

RUN mvn -f /tmp/pom.xml -B -s /usr/share/maven/ref/settings-docker.xml dependency:resolve

RUN mkdir code

COPY . /code

WORKDIR /code

RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml test

#RUN mkdir code

#COPY . /code

#WORKDIR /code

#####


# RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml test

# RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml install



# RUN pwd

# RUN cd

# RUN  ls -la

# RUN find / -name .m2

# RUN mvn install -DskipTests

# RUN mvn verify clean --fail-never

# RUN find / -name .m2
