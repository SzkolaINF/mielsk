#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script"
    exit 1
fi


export BR_ADDR="10.10.0.1"
export BR_DEV="br0"

export NS1="ns1"
export VETH1="veth1"
export VPEER1="vpeer1"
export VPEER_ADDR1="10.10.0.10"

export NS2="ns2"
export VETH2="veth2"
export VPEER2="vpeer2"
export VPEER_ADDR2="10.10.0.20"


# remove namespace if it exists.
sudo ip netns del $NS1 &>/dev/null
sudo ip netns del $NS2 &>/dev/null


# create namespace
sudo ip netns add $NS1
sudo ip netns add $NS2

# create veth link
sudo ip link add ${VETH1} type veth peer name ${VPEER1}
sudo ip link add ${VETH2} type veth peer name ${VPEER2}

# setup veth link
sudo ip link set ${VETH1} up
sudo ip link set ${VETH2} up

# add peers to ns
sudo ip link set ${VPEER1} netns ${NS1}
sudo ip link set ${VPEER2} netns ${NS2}

# setup loopback interface
sudo ip netns exec ${NS1} ip link set lo up
sudo ip netns exec ${NS2} ip link set lo up

# setup peer ns interface
sudo ip netns exec ${NS1} ip link set ${VPEER1} up
sudo ip netns exec ${NS2} ip link set ${VPEER2} up

# assign ip address to ns interfaces
sudo ip netns exec ${NS1} ip addr add ${VPEER_ADDR1}/16 dev ${VPEER1}
sudo ip netns exec ${NS2} ip addr add ${VPEER_ADDR2}/16 dev ${VPEER2}


# setup bridge
sudo ip link add ${BR_DEV} type bridge
sudo ip link set ${BR_DEV} up

# assign veth pairs to bridge
sudo ip link set ${VETH1} master ${BR_DEV}
sudo ip link set ${VETH2} master ${BR_DEV}

# setup bridge ip
sudo ip addr add ${BR_ADDR}/16 dev ${BR_DEV}

# add default routes for ns
#sudo ip netns exec ${NS1} ip route add default via ${BR_ADDR}
#sudo ip netns exec ${NS2} ip route add default via ${BR_ADDR}

# enable ip forwarding
sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'

# Flush nat rules.
#sudo iptables -t nat -F


#sudo iptables -t nat -A POSTROUTING -s ${BR_ADDR}/16 ! -o ${BR_DEV} -j MASQUERADE

#---
#sudo docker inspect -f '{{.State.Pid}}'
#sudo ln -s /proc/44356/ns/net /var/run/netns/44356

#export alpine1ns=`sudo docker inspect -f '{{.State.Pid}}' alpine-net1`
#export alpine2ns=`sudo docker inspect -f '{{.State.Pid}}' alpine-net2`
#export alpinerns=`sudo docker inspect -f '{{.State.Pid}}' alpine-router`
