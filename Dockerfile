FROM jenkins/jenkins:lts
USER root

# 1. Match your host system's group ID
ARG DOCKER_GID=1001

# 2. Download the actual tarball package instead of the HTML homepage
RUN mkdir -p /tmp/download && \
    curl -L https://docker.com | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download && \
    # 3. Apply group configurations
    groupadd -g ${DOCKER_GID} docker && \
    usermod -aG staff,docker jenkins

USER jenkins
