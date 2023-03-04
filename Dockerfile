FROM ubuntu:latest
EXPOSE 25565
RUN apt-get update && apt-get install -y sudo
RUN sudo sh install.sh
