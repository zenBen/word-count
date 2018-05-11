#version 0.1
FROM ubuntu:16.04

#maintainer information
LABEL maintainer="kthw@kth.se"

# update the apt package manager
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update

# install make
RUN apt-get install -y build-essential

# install nano
RUN apt-get install -y nano

# install python
RUN apt-get install -y python3.6 python3.6-dev python3-pip python3.6-venv
RUN yes | pip3 install numpy
RUN yes | pip3 install matplotlib
RUN yes | pip3 install snakemake


# copy project to container 
COPY ./ /opt/word_count/

# set work directory in container
WORKDIR /opt/word_count

# default command to execute when container starts 
CMD /bin/bash
