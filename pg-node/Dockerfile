FROM postgres:9.4
MAINTAINER Biju Joseph <biju.joseph@semanticbits.com>

RUN apt-get update && apt-get install -y \
    openssh-server \
    openjdk-7-jdk \
    curl \
    git \
    python-yaml

RUN curl -O https://bootstrap.pypa.io/get-pip.py \
    && python2.7 get-pip.py \
    && pip install awscli

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

RUN apt-get update && apt-get install -y nodejs
ENV PHANTOMJS_BIN "/usr/local/bin/phantomjs"
RUN npm install -g phantomjs-prebuilt

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
    && mkdir -p /var/run/sshd

# Add user jenkins to the image
RUN adduser --quiet jenkins \
    && echo "jenkins:jenkins" | chpasswd

RUN mkdir /home/jenkins/.ssh \
    && touch /home/jenkins/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> /home/jenkins/.ssh/known_hosts \
    && ssh-keyscan -t rsa gitlab.com >> /home/jenkins/.ssh/known_hosts\ \
    && mkdir /home/jenkins/.aws \
    && touch /home/jenkins/.aws/credentials \
    && echo "[default]" >> /home/jenkins/.aws/credentials \
    && chown -R jenkins:jenkins /home/jenkins/.aws

COPY entrypoint.sh /
RUN chmod 777 /entrypoint.sh

# Standard SSH and postgres
EXPOSE 22 5432

ENTRYPOINT ["/entrypoint.sh"]
