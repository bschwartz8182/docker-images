FROM mysql:5.7
MAINTAINER Biju Joseph <biju.joseph@semanticbits.com>

RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    git \
    bzip2 \
    tar \
    python-yaml \
    wget
    
RUN mkdir -p /opt/java \
    && cd /opt/java \
    && wget -P /opt/java --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz \
    && tar xfs /opt/java/jdk-8u121-linux-x64.tar.gz -C /opt/java/ \
    && update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_121/bin/java 9999 \
    && update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_121/bin/javac 9999

RUN curl -O https://bootstrap.pypa.io/get-pip.py \
    && python2.7 get-pip.py \
    && pip install awscli

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install -y nodejs
ENV PHANTOMJS_BIN "/usr/local/bin/phantomjs"
RUN npm install -g phantomjs-prebuilt
RUN npm install -g babel-cli gulp nodemon

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

RUN mkdir /root/.ssh
ARG GIT_SSH_KEY=
ENV GIT_SSH_KEY $GIT_SSH_KEY
RUN echo $GIT_SSH_KEY > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config

COPY entrypoint.sh /
RUN chmod 777 /entrypoint.sh

# Standard SSH and mysql
EXPOSE 22 3306

ENTRYPOINT ["/entrypoint.sh"]
