FROM maven:3.3-jdk-8 
#FROM cloudbees/java-build-tools:latest 
# FROM jenkins/ssh-slave:latest


##SSH STUFF

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

RUN apt-get update \
    && apt-get install --no-install-recommends -y openssh-server \
    && rm -rf /var/lib/apt/lists/*
RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/sshd

VOLUME "${JENKINS_AGENT_HOME}" "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY seeder/setup-sshd /usr/local/bin/setup-sshd
RUN chmod 755 /usr/local/bin/setup-sshd

## preseed mvn packages

RUN mkdir -p seed/maven/ref/repository

WORKDIR /home/jenkins/seed

#RUN cat /usr/share/maven/ref/settings-docker.xml

COPY pom.xml /tmp/pom.xml

COPY seeder/settings.xml /usr/share/maven/ref/repository/settings-docker.xml

RUN mvn -f /tmp/pom.xml -B -s /usr/share/maven/ref/repository/settings-docker.xml dependency:resolve

COPY . .

RUN mvn -B -s /usr/share/maven/ref/repository/settings-docker.xml test

RUN du -s -h .

EXPOSE 22

ENTRYPOINT ["setup-sshd"]

