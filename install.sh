#!/bin/bash
sudo apt update
sudo apt install -y wget
wget -O jdk-8u221-linux-x64.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u221-b11/230deb18db3e4014bb8e3e8324f81b43/jdk-8u221-linux-x64.tar.gz"
sudo mkdir /usr/lib/jvm
sudo tar -xvzf jdk-8u221-linux-x64.tar.gz -C /usr/lib/jvm
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_221/bin/java" 1
sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_221/bin/java
# Download PaperMC server jar file
wget https://api.papermc.io/v2/projects/paper/versions/1.19.3/builds/431/downloads/paper-1.19.3-431.jar
# Download ngrok zip file
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
# Unzip ngrok file
unzip ngrok-stable-linux-amd64.zip
# Run PaperMC server
java -jar paper-1.19.3.jar
# Run ngrok and expose port 25565
ngrok tcp 25565
