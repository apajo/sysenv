FROM ubuntu:20.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y apt-utils

RUN apt-get install -y curl gzip sudo xz-utils git wget

RUN useradd -ms /bin/bash apajo
RUN usermod -aG sudo apajo
RUN passwd -d apajo

COPY ./test/files /root
COPY ./test/files /home/apajo
COPY ./ /etc/sysenv

RUN sudo chown -R apajo:apajo /home/apajo/*

USER root
WORKDIR /home/apajo
CMD ["/bin/bash"]
#CMD ["./run"]
