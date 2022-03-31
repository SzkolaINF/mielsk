#!/bin/bash

echo "------------------WITAJ W INSTALATORZE!---------------"
echo " Co chcesz zainstalowac? :"
echo "1) Podstawowa konfiguracja (passwd, update)"
echo "2) GNS3"
echo "3) Konfiguracja karty sieciowej"
echo "4) Docker"
echo "5) Wszystko"
echo "------------------------------------------------------"
echo -n "Jaki jest twoj wybor? (wpisz liczbe) :"
read wybor
echo -n "Podaj nazwe uzytkownika: "
read user

if [ $wybor == 1 ]
	sudo passwd
	sudo apt update
elif [ $wybor == 2 ]
	 sudo apt install -y python3-pip
	 sudo apt install -y python3-pyqt5 python3-pyqt5.qtsvg python3-pyqt5.qtwebsockets
	 sudo apt install -y qemu qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst
	 sudo apt install -y wireshark
	 sudo apt remove docker docker-engine docker.io
	 curl -fsSL https://get.docker.com/ | sh
	 sudo apt install -y dynamips
	 git clone https://github.com/GNS3/ubridge
	 cd ubridge/
	 sudo apt install -y libpcap-dev
	 make
	 sudo make install
	 sudo pip3 install gns3-server
	 sudo pip3 install gns3-gui
	 sudo usermod -aG libvirt,kvm,wireshark,docker $user
	 sudo apt install gnome-terminal
	 echo "wyloguj sie i zaloguj!"
elif [ $wybor == 3 ]
	sudo apt install -y  dkms git build-essential libelf-dev linux-headers-$(uname -r)
	git clone https://github.com/aircrack-ng/rtl8812au.git
	cd rtl8812au/
	sudo make dkms_install
	sudo dkms status
	echo " wyciagnij karte i wsadz spowrotem!"
elif [ $wybor == 4 ]
	sudo apt install -y python3-pip
	sudo apt install -y python3-pyqt5 python3-pyqt5.qtsvg python3-pyqt5.qtwebsockets
	sudo apt install -y qemu qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst
	curl -fsSL https://get.docker.com/ | sh
	sudo apt install -y docker.io
elif [ $wybor == 5 ]
	sudo passwd
	sudo apt update -y
	sudo apt install -y dkms git build-essential libelf-dev linux-headers-$(uname -r)
	git clone https://github.com/aircrack-ng/rtl8812au.git
	cd rtl8812au/
	sudo make dkms_install
	sudo dkms status
	echo " wyciagnij karte i wsadz spowrotem!"
	git clone https://github.com/GNS3/ubridge
	cd ubridge/
	sudo apt install -y libpcap-dev
	make
	sudo make install
	sudo pip3 install gns3-server                                                                     
	sudo pip3 install gns3-gui
	sudo usermod -aG libvirt,kvm,wireshark,docker $user
	sudo apt install gnome-terminal
	echo "wyloguj sie i zaloguj!"
	                           
fi
