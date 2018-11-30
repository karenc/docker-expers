##
## Create an image that can be used to play with
## easybake commands.
##
## To create the image:
##    docker build -t <username>/easybake:latest .
##
## To start the container:
##    docker run --mount type=bind,source=$(pwd)/cnx-easybake,target=/repos/cnx-easybake -it <username>/easybake:latest /bin/bash
## where the cnx-easybake repo has been cloned into the
## current working directory.
##
## To run the code:
##    . ./scripts/test
## See:
##    https://github.com/Connexions/cnx-easybake
## for details.
##

FROM ubuntu:latest as baseline
WORKDIR /
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get -y install ed
RUN apt-get -y install git
RUN apt-get -y install vim
RUN apt-get -y install gnupg
RUN apt-get -y install make
RUN apt-get -y install build-essential
RUN apt-get -y install libx11-dev
RUN apt-get -y install libicu-dev

FROM baseline as install-python
WORKDIR /
RUN apt-get -y install python-dev
RUN apt-get -y install python-pip
RUN pip install virtualenv
RUN mkdir ~/.virtualenvs
RUN pip install virtualenvwrapper
