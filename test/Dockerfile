FROM ubuntu:20.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y apt-utils

RUN apt-get install -y curl gzip sudo xz-utils git wget

RUN useradd -ms /bin/bash apajo
RUN usermod -aG sudo apajo
RUN passwd -d apajo

COPY ./files /root
COPY ./files /home/apajo

RUN sudo chown -R apajo:apajo /home/apajo/*

USER apajo
WORKDIR /home/apajo
CMD ["/bin/bash"]
#CMD ["./run"]
