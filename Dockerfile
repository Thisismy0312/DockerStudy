#基于官方的ubuntu镜像
FROM ubuntu:20.04

RUN apt update
RUN apt install -y software-properties-common
RUN apt install -y build-essential 
RUN apt install -y vim 
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.9
RUN apt-get install -y curl
# Install pip from standard ubuntu packages
RUN apt-get install -y python3-pip
RUN python3.9 -m pip install pip --upgrade
RUN python3.9 -m pip install wheel
RUN apt install -y git
RUN apt-get install -y rake
RUN apt-get install -y openssh-client
RUN apt-get install -y openssh-server
