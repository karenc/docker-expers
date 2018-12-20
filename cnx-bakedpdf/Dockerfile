##
## Create an image that can be used to play with
## baked-pdf commands.
##
## To create the image:
##    docker build -t <username>/bakedpdf:latest .
##
## To start the container:
##    docker run --mount type=bind,source=$(pwd)/baked-pdf,target=/repos/baked-pdf -it <username>/bakedpdf:latest /bin/bash
## where the baked-pdf repo has been cloned into the
## current working directory.
##
## To run the code:
##    cd /repos/baked-pdf/typeset
##    node start -i <input> -c <style> -o <output>
## where <X> are filenames, e.g.:
##    node start -i ../test-simple.xhtml -o output.html
## See:
##    https://github.com/Connexions/baked-pdf
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
## from: https://github.com/GoogleChrome/puppeteer/issues/404
RUN apt-get -y install libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0

FROM baseline as install-node
WORKDIR /
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

FROM install-node as npm-install
COPY ./baked-pdf /repos/baked-pdf
WORKDIR /repos/baked-pdf/typeset
RUN npm install
