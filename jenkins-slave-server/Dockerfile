# This Dockerfile is used to build an image containing an node jenkins slave used for server

FROM teracy/angular-cli
MAINTAINER Biju Joseph <biju.joseph@semanticbits.com>
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
RUN apt-get install -y openssh-server
RUN apt-get install -y openjdk-7-jdk
ENV PHANTOMJS_BIN "/usr/local/bin/phantomjs"
RUN npm install -g phantomjs-prebuilt


RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd


# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd
RUN mkdir /home/jenkins/.ssh
RUN touch /home/jenkins/.ssh/known_hosts
RUN ssh-keyscan -t rsa github.com >> /home/jenkins/.ssh/known_hosts
RUN ssh-keyscan -t rsa gitlab.com >> /home/jenkins/.ssh/known_hosts



# Standard SSH port
EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]