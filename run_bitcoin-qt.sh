#!/bin/bash

echo "deleting all old docker container ..."
docker rm $(docker ps -a -q)

echo "running bitcoin-qt in a docker container ..."

#no need for --user user . Its already specified in the Dockerfile to run as user (needed for X11)
docker run -it \
	--name bitcoin_d \
	-v /home/user/.bitcoin/:/home/user/.bitcoin \
	-v /media/user/shared_chaindata/bitcoin_chaindata/bitcoin/blocks/:/home/user/.bitcoin/blocks/ \
	-v /media/user/shared_chaindata/bitcoin_chaindata/bitcoin/chainstate/:/home/user/.bitcoin/chainstate/ \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
 	-v ~/.Xauthority:/home/user/.Xauthority \
	--env DISPLAY=:0 \
	bitcoincore


