#!/bin/bash
clear
echo -n "Podaj nazwe uzytkownika: "
read user
clear
sudo apt update
sudo apt install -y git
git clone https://github.com/SzkolaINF/mielsk.git
cd mielsk/
cd script-static-routing/
chmod 777 *
mv * /home/$user/
cd
sudo ./x2veth-br.sh 
sudo apt install docker.io -y
sudo chmod 777 /var/run/docker.sock
docker network create net1 --subnet=172.19.0.0/16
docker network create net2 --subnet=172.20.0.0/16
docker run -dit --name alpine-net1 --privileged --net="net1" alpine
docker run -dit --name alpine-net2 --privileged --net="net2" alpine
docker run -dit --name alpine-router --privileged --net="net1" alpine
docker network connect net2 alpine-router
sudo ip netns exec ns1 route add -net 172.19.0.0 netmask 255.255.0.0 gw 10.10.0.30 vpeer1
sudo ip netns exec ns1 route add -net 172.20.0.0 netmask 255.255.0.0 gw 10.10.0.30 vpeer1
sudo ip netns exec ns2 route add -net 172.19.0.0 netmask 255.255.0.0 gw 10.10.0.30 vpeer2
sudo ip netns exec ns2 route add -net 172.20.0.0 netmask 255.255.0.0 gw 10.10.0.30 vpeer2
export BR_ADDR="10.10.0.30"
export BR_DEV="br0"
export NS1="ns1"
export VETH1="veth1"
export VPEER1="vpeer1"
export VPEER_ADDR1="10.10.0.10"
export NS2="ns2"
export VETH2="veth2"
export VPEER2="vpeer2"
export VPEER_ADDR2="10.10.0.20"
sudo ip link set ${VETH1} master ${BR_DEV}
sudo ip link set ${VETH2} master ${BR_DEV}
sudo ip netns exec ns1 ping 10.10.0.20
./expose-netns.sh alpine-net1
./expose-netns.sh alpine-net2
./expose-netns.sh alpine-router
./add-nic-veth-pair.sh alpine-net1 veth-1 peer-1 br0 10.10.0.30
sudo docker exec -it alpine-net1 route add -net 172.20.0.0 netmask 255.255.0.0 gw 172.19.0.3 eth0
sudo docker exec -it alpine-net2 route add -net 172.19.0.0 netmask 255.255.0.0 gw 172.20.0.3 eth0
sudo ip netns exec ns1 ping -c 3 10.10.0.20
sudo ip netns exec ns1 ping -c 3 172.20.0.2
sudo ip netns exec ns1 ping -c 3 172.19.0.2
