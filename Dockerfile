#write a docker file that deploys a ubuntu container with dnsutils installed and keeps the container running
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common dnsutils openssh-server && \
    apt-get clean && \
    mkdir /var/run/sshd && \
    useradd -m -d /home/ubuntu -s /bin/bash ubuntu && \
    touch /home/ubuntu/.bashrc && \
    touch /home/ubuntu/.profile && \
    echo 'ubuntu:ubuntuP@ssword123' | chpasswd && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]