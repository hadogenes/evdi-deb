#!/bin/bash -e

apt update
apt install -y build-essential devscripts debhelper \
    wget equivs

cd base-src

# Install deps
mk-build-deps -i

make
