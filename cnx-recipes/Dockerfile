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
## from: https://github.com/GoogleChrome/puppeteer/issues/404
RUN apt-get -y install libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0
RUN apt-get -y install libxml2-utils
RUN apt-get -y install libxslt1-dev libxml2-dev zlib1g-dev # For lxml to compile
RUN apt-get -y install xsltproc                       # for generating epub

FROM baseline as install-python
WORKDIR /
RUN apt-get -y install python-dev
RUN apt-get -y install python-pip
RUN pip install virtualenv
RUN mkdir ~/.virtualenvs
RUN pip install virtualenvwrapper

FROM install-python as install-node
WORKDIR /
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

FROM install-node as install-yarn
WORKDIR /
RUN npm install -g yarn
