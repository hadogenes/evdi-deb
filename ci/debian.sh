#!/bin/bash -e

apt update
apt install -y build-essential devscripts debhelper \
    wget \
    dkms

cd base-src
make
