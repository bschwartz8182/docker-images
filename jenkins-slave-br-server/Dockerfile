FROM mysql:5.7
MAINTAINER Biju Joseph <biju.joseph@semanticbits.com>

RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    git \
    bzip2 \
    tar \
    python-yaml \
    wget \
    libfontconfig \
    build-essential
    
RUN mkdir -p /opt/java \
    && cd /opt/java \
    && wget -P /opt/java --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz \
    && tar xfs /opt/java/jdk-8u131-linux-x64.tar.gz -C /opt/java/ \
    && update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_131/bin/java 9999 \
    && update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_131/bin/javac 9999

RUN curl -O https://bootstrap.pypa.io/get-pip.py \
    && python2.7 get-pip.py \
    && pip install awscli

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update && apt-get install -y nodejs

RUN npm install -g yarn
ENV PHANTOMJS_BIN "/usr/local/bin/phantomjs"
RUN yarn global add phantomjs-prebuilt
RUN npm install -g babel-cli gulp nodemon

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
    && mkdir -p /var/run/sshd

# Add user jenkins to the image
RUN adduser --quiet jenkins \
    && echo "jenkins:jenkins" | chpasswd

RUN su - jenkins -s /bin/bash -c "mkdir /home/jenkins/.ssh"
RUN touch /home/jenkins/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> /home/jenkins/.ssh/known_hosts \
    && ssh-keyscan -t rsa gitlab.com >> /home/jenkins/.ssh/known_hosts\ \
    && mkdir /home/jenkins/.aws \
    && touch /home/jenkins/.aws/credentials \
    && echo "[default]" >> /home/jenkins/.aws/credentials \
    && chown -R jenkins:jenkins /home/jenkins/.aws

COPY entrypoint.sh /
RUN chmod 777 /entrypoint.sh

# Standard SSH and mysql
EXPOSE 22 3306

ENTRYPOINT ["/entrypoint.sh"]
