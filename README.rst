CNX Pipeline
============

This repository contains docker images for generating pdfs, allowing developers
to easily generate pdfs locally.

Installation
------------

Install ``docker`` and ``docker-compose`` on your machine.  If you are using
ubuntu::

    sudo apt-get install docker.io docker-compose

Clone this repository and set up the submodules::

    git clone -b karen git@github.com:karenc/docker-expers.git
    cd docker-expers
    git submodule init
    git submodule update

Build the docker images::

    docker-compose build

Download a book
---------------

In order to download a book, you need to be able to ssh into a cnx server.  For
example, to download statistics::

    ./script/fetch-html statistics

The list of books are defined in `books.txt <https://github.com/openstax/cnx-recipes/blob/002bbf796ae8988beb2b6307e65245079534844f/books.txt#L39-L73>`_.

Optionally, you can download the book from a different server by adding
``HOST=<hostname>`` and ``USER=<ssh-username>`` to the above command line.

If you have a ssh key (e.g. ``~/.ssh/id_rsa``), copy that ssh key to
``fetch_book_rsa`` before running the command.

If the book downloads successfully, you should see
``out/data/statistics-raw.xhtml``.

Generate PDFs
-------------

Once you have a book locally, you can bake the book and generate a PDF by doing::

    ./script/bake statistics

If you want to add a css file to the pdf, you can add the file to ``out/`` and
add ``STYLE=filename.css`` to the above command line.

By default, math is transformed to svg, if you want to change that to html, you
can add ``MATH_FORMAT=html`` to the above command line.

If the PDF is generated successfully, you should see ``out/statistics.pdf``.
