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
sudo ip link add $VETH type veth peer name $PEER

sudo ip link set ${VETH} up


#echo "add port to ovs bridge $OVS_BR"
#ovs-vsctl add-port $OVS_BR $VETH

echo "add port to bridge $BR"
sudo ip link set ${VETH} master ${BR}


echo "move $PEER to netns $NETNS"
sudo ip link set $PEER netns $NETNS

#sudo ip netns exec $NETNS ip link set dev $PEER up

sudo ip netns exec ${NETNS} ip link set ${PEER} up
sudo ip netns exec ${NETNS} ip addr add ${PEER_ADDR}/16 dev ${PEER}


echo "done"
