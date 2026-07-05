# Add a build argument for the GID stat -c '%g' /var/run/docker.sock on your local machine
ARG DOCKER_GID=1001

RUN mkdir -p /tmp/download && \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download && \
    # Use the build argument here
    groupadd -g ${DOCKER_GID} docker && \
    usermod -aG staff,docker jenkins

USER jenkins
