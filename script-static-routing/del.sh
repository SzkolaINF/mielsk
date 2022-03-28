#!/bin/sh

if [ $# -lt 3 ]; then
    echo "Usage: $0 <CONTAINER> <VETH> <PEER> <BRIDGE> <IP>"
    echo "Example: $0 alpine-net1 veth-1 peer-1 br0 10.10.0.30"
    exit 1
fi

CONTAINER=$1

VETH=$2
PEER=$3

BR=$4

export PEER_ADDR=$5

NETNS=`sudo docker inspect -f '{{.State.Pid}}' $CONTAINER`

echo "add veth pair[$VETH <--> $PEER] to container[$CONTAINER] in netns[$NETNS]"

sudo ip link delete $VETH || true
echo "done"
