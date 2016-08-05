Sparkerl Server
===============

A server for the Spark protocol. ALPHA! Eventually this could replace the
Particle NodeJS server. Right now it is mostly a debug server.


Developing Locally
==================

Install Erlang R19

    make deps app shell


Add Keys
========

Keys for your cores need to be added to the `keys/` directory. This can be done
with the Particle CLI. I need to find a good way to get the ID :/

    particle keys save keys/ID
