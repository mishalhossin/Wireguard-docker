FROM ubuntu:18.04
USER root
EXPOSE 51820
RUN apt-get update && apt-get install -y curl
RUN curl https://raw.githubusercontent.com/mishalhossin/Wireguard-docker/main/install.sh | bash
