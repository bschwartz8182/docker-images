# This Dockerfile is used to build an image containing an node jenkins slave used for server

FROM teracy/angular-cli

MAINTAINER Biju Joseph <biju.joseph@semanticbits.com>

RUN apt-get update && apt-get install -y \
    openssh-server \
    openjdk-7-jdk \
    python-yaml

RUN curl -O https://bootstrap.pypa.io/get-pip.py \
    && python2.7 get-pip.py \
    && pip install awscli

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
    && chown -R jenkins:jenkins /home/jenkins/.aws \
    && echo "DISPLAY=:99" >> /etc/environment

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]