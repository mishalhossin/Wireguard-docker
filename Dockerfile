FROM ubuntu:18.04
USER root
EXPOSE 51820
EXPOSE 443 # or 80 depending on the protocol
RUN apt-get update && apt-get install -y curl
RUN curl https://example.com/raw-code.sh | bash
