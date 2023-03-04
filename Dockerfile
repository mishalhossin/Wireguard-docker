FROM ubuntu:18.04
USER root
EXPOSE 51820
RUN apt-get update && apt-get install -y curl
RUN curl https://example.com/raw-code.sh | bash
