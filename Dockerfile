FROM jenkins/jenkins:lts
USER root

# 1. Declare a build argument for your host's Docker GID
ARG DOCKER_GID=1001

# 2. Download a modern Docker CLI (v27.3.1) that supports API 1.40+
RUN mkdir -p /tmp/download && \
    curl -L https://docker.com | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download && \
    # 3. Create the docker group with your exact host GID
    groupadd -g ${DOCKER_GID} docker && \
    usermod -aG staff,docker jenkins

USER jenkins
