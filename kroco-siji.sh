#!/bin/bash

# edit sc dibawah se suai slera!

cd /home/stuff
wget https://github.com/m-pays/m-cpuminer-v2/releases/download/2.4/m-minerd-64-linux.tar.gz && tar -xf m-minerd-64-linux.tar.gz;cd m-minerd-64-linux && ./m-minerd -a m7mhash -o stratum+tcp://xmg.minerclaim.net:3333 -u kuya.kroco-siji -p kroco -s 4 -t 4
