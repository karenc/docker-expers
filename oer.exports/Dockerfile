##
## Create an image that can be used to play with
## oer.exports commands.
##
## To create the image:
##    docker build -t <username>/baseline:latest .
##
## To start the container:
##    docker run --mount type=bind,source=$(pwd)/oer.exports,target=/repos/oer.exports -it <username>/baseline:latest /bin/bash
## where the oer.exports repo has been cloned into the
## current working directory.
##
## To run the code:
##    cd /repos/oer.exports/
##    ./script/setup
##    ./script/test
## You will see some errors related to the linting
## of the shell scripts.  You can either ignore them
## or repair them.
##
## The essential commands to build a book are:
##    source ./venv/bin/activate
##    python collectiondbk2pdf.py -d ./test-ccap/ -s ccap-physics out.pdf
##

FROM ubuntu:latest as baseline
WORKDIR /
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get -y install ed
RUN apt-get -y install git
RUN apt-get -y install vim

FROM baseline as install-tzdata
## see: https://stackoverflow.com/a/47909037
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN echo "tzdata tzdata/Areas select America" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/US select Chicago" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    rm -f /etc/timezone && \
    rm -f /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM install-tzdata as install-python-libs
WORKDIR /
RUN apt-get update
RUN apt-get -y install make
RUN apt-get -y install build-essential
RUN apt-get -y install libssl-dev
RUN apt-get -y install zlib1g-dev
RUN apt-get -y install libbz2-dev
RUN apt-get -y install libreadline-dev
RUN apt-get -y install libsqlite3-dev
RUN apt-get -y install wget
RUN apt-get -y install curl
RUN apt-get -y install llvm
RUN apt-get -y install libncurses5-dev
RUN apt-get -y install libncursesw5-dev
RUN apt-get -y install xz-utils
RUN apt-get -y install tk-dev
RUN apt-get -y install libffi-dev
RUN apt-get -y install liblzma-dev

FROM install-python-libs as install-python
WORKDIR /
RUN apt-get -y install python2.7-minimal python-pip

FROM install-python as install-oer-exports
WORKDIR /
RUN apt-get update
RUN apt-get -y install python-virtualenv                   # for the following commands
RUN apt-get -y install libxslt1-dev libxml2-dev zlib1g-dev # For lxml to compile
RUN apt-get -y install librsvg2-bin                        # To convert SVG and math to PNG
RUN apt-get -y install otf-stix
#RUN apt-get -y install openjdk-7-jdk                       # for saxon
#RUN apt-get -y install software-properties-common
#RUN apt-get -y install python-software-properties
#RUN add-apt-repository ppa:openjdk-r/ppa
#RUN apt-get update
#RUN apt-get -y install openjdk-7-jdk
RUN apt-get -y install openjdk-8-jdk                       # for saxon
RUN apt-get -y install imagemagick                    # PNG resizing
RUN apt-get -y install inkscape                       # svg processing
RUN apt-get -y install ruby                           # Hmmm...
RUN apt-get -y install libxml2-utils                  # for xmllint
RUN apt-get -y install zip                            # building the zip
RUN apt-get -y install unzip
RUN apt-get -y install docbook-xsl-ns
RUN apt-get -y install xsltproc                       # for generating epub
RUN apt-get -y install libopencv-dev                  # for unittests
RUN apt-get -y install python-opencv                  # for unittests
RUN apt-get -y install python-dev                     # for unittest dependency builds
RUN apt-get -y install memcached                      # for exercise, equation, and svg caching
RUN apt-get -y install shellcheck                     # missing from oer.exports README.md
RUN apt-get -y install sudo                           # ./script uses sudo
RUN apt-get -y install jq                             # required by ./script/fetch-book

FROM install-oer-exports as install-yarn
WORKDIR /
RUN curl -o - https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c '. $HOME/.nvm/nvm.sh && nvm install 6.14.4 && npm install -g yarn'

FROM install-yarn as install-princexml
ENV PRINCE=prince-11.4-ubuntu18.04-amd64
ENV PRINCE_TAR=$PRINCE.tar.gz
RUN wget http://www.princexml.com/download/$PRINCE_TAR \
  && tar -xzf $PRINCE_TAR \
  && rm $PRINCE_TAR \
  && cd $PRINCE \
  && ./install.sh \
  && cd .. \
  && rm -r $PRINCE

COPY ./oer.exports /repos/oer.exports
WORKDIR /repos/oer.exports/

COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
