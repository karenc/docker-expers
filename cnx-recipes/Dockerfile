##
## Create an image that can be used to play with
## cnx-recipes commands.
##
## To create the image:
##    docker build -t <username>/recipes:latest .
##
## To start the container:
##    docker run --mount type=bind,source=$(pwd)/cnx-recipes,target=/repos/cnx-recipes -it <username>/recipes:latest /bin/bash
## where the cnx-recipes repo has been cloned into the
## current working directory.
##
## To run the code:
##    . ./scripts/test
## See:
##    https://github.com/Connexions/cnx-recipes
## for details.
##

FROM ubuntu:latest as baseline
WORKDIR /
RUN mkdir .ssh && chmod 700 .ssh
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
RUN apt-get -y install libxml2-utils
RUN apt-get -y install libxslt1-dev libxml2-dev zlib1g-dev # For lxml to compile
RUN apt-get -y install xsltproc                       # for generating epub
RUN apt-get -y install unzip                          # required by fetch-html

FROM baseline as install-python
WORKDIR /
RUN apt-get -y install python-dev
RUN apt-get -y install python-pip
RUN pip install virtualenv
RUN mkdir ~/.virtualenvs
RUN pip install virtualenvwrapper

FROM install-python as install-node
COPY ./cnx-recipes /repos/cnx-recipes
WORKDIR /repos/cnx-recipes/
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c '. $HOME/.nvm/nvm.sh && nvm install $(cat .node-version)'

FROM install-node as install-yarn
RUN /bin/bash -c '. $HOME/.nvm/nvm.sh && npm install -g yarn'

COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
