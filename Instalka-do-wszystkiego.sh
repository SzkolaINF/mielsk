#!/bin/bash

user=$(whoami)
if [[ -f /home/$user/Instalka-do-wszystkiego.sh ]]
then
clear
echo "---------------witaj $user-------------"
sleep 0.1
echo "1) Programy itp"
sleep 0.1
echo "2) Pobieranie"
sleep 0.1
echo "3) strony"
echo " "
echo -n "Twoj Wybor: "
read wybor1

if [ $wybor1 == 1 ]
then 
clear
	sleep 0.1
	echo " Co chcesz zainstalowac? :"
	sleep 0.1
	echo "1) Podstawowa konfiguracja (passwd, update)"
	sleep 0.1
	echo "2) GNS3"
	sleep 0.1
	echo "3) Konfiguracja karty sieciowej"
	sleep 0.1
	echo "4) Docker"
	sleep 0.1
	echo "5) Minecraft"
	sleep 0.1
	echo "6) Player anime"
	sleep 0.1
	echo "7) Powrot"
	sleep 0.3
	echo " "
	echo -n "Wybierz liczbe: "
	read wybor
	clear
		if [ $wybor == 1 ]
		then
		clear
		sudo passwd
		sudo apt update
		exec "./Instalka-do-wszystkiego.sh"
		exit
		elif [ $wybor == 2 ]
		then
		clear
		sudo apt update
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
		sudo apt install -y gnome-terminal
		echo "wyloguj sie i zaloguj!"
		exec "./Instalka-do-wszystkiego.sh"
		exit
		elif [ $wybor == 3 ]
		then
		clear
		sudo apt update
		cd
		sudo apt install -y wget 
		wget https://download1076.mediafire.com/6z50t3ikfqjg/4tw3y1f0aoxwk16/wifi.zip
		unzip wifi.zip
		cd rtl8812au
		sudo make install
		echo " wyciagnij karte i wsadz spowrotem!"
		exec "./Instalka-do-wszystkiego.sh"
		exit
		elif [ $wybor == 4 ]
		then
		clear
		sudo apt update	
		sudo apt install -y python3-pip
		sudo apt install -y python3-pyqt5 python3-pyqt5.qtsvg python3-pyqt5.qtwebsockets
		sudo apt install -y qemu qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst
		curl -fsSL https://get.docker.com/ | sh
		sudo apt install -y docker.io
		exec "./Instalka-do-wszystkiego.sh"
		exit
		elif [ $wybor == 5 ]
		then
		clear
		if [[ -f /home/$user/TLauncher-2.841.jar  ]]
		then
		echo "milej gry"
		sleep 2
		sudo java -jar /home/$user/TLauncher-2.841.jar
		exec "./Instalka-do-wszystkiego.sh"
		else
		echo "minecraft zaraz zostanie pobrany"
		sleep 2
		curl https://dl2.tlauncher.org/f.php?f=files%2FTLauncher-2.841.zip -o /home/$user/minecraft.zip
		cd /home/$user/
		unzip minecraft.zip 
		sudo apt install -y default-jdk
		sudo java -jar TLauncher-2.841.jar
		exec "./Instalka-do-wszystkiego.sh"
		fi
		elif [ $wybor == 6 ]
		then
			if [[ -f /usr/local/bin/ani-cli ]]
			then
				echo " "
				ani-cli
			else
				echo "zaraz zostanie zainstalowany"
				echo 'aby wlaczyc samemu wpisz "ani-cli" '
				echo "lub uruchom ocje anime player w skrypcie ponownie"
				sleep 5
				clear
				sudo apt install -y git
				git clone https://github.com/pystardust/ani-cli
				cd ani-cli
				sudo cp ani-cli /usr/local/bin/ani-cli
				cd /home/$user/
				clear
				ani-cli
			fi
	elif [ $wybor == 7 ]
		then
		exec "./Instalka-do-wszystkiego.sh"
		exit
		fi
		

elif [ $wybor1 == 2 ]
then
	clear
	echo "1) mielsk"
	sleep 0.1
	echo "2) Programowanie + visual studio code"
	sleep 0.1
	echo "3) wlasny link"
	sleep 0.1
	echo "4) wifi.zip"
	sleep 0.1
	echo "5) powrot"
	sleep 0.2
	echo " "
	echo -n "Jaki jest twoj wybor? (wpisz liczbe): "
	read wybor

	if [ $wybor == 1 ]
	then
		clear
		sudo apt update
		sudo apt install -y git
		git clone https://github.com/SzkolaINF/mielsk.git
		exec "./Instalka-do-wszystkiego.sh"
		exit

	elif [ $wybor == 2 ]
	then
		clear
		sudo apt update
		sudo apt install -y wget
		sudo apt install -y dpkg
		sudo apt install -y git
		git clone https://github.com/SzkolaINF/Programowanie.git 
		wget https://download1580.mediafire.com/jrr0t0vrsugg/xsqhxtd81xisqfe/code_1.66.2-1649664567_amd64.deb
		sudo apt install -y ./code_1.66.2-1649664567_amd64.deb
		mkdir workspace
		cd workspace
		code .
	elif [ $wybor == 3 ]
	then
		clear
		sudo apt update 
		clear
		echo -n "link: "
		read link
		sudo apt install -y git
		git clone $link
		exec "./Instalka-do-wszystkiego.sh"
		exit
	elif [ $wybor == 4 ]
	then
	sudo apt install -y wget
	wget https://download1591.mediafire.com/kvuhgc62s8qg/u1ik99ht17jgjw1/wifi.zip
	exec "./Instalka-do-wszystkiego.sh"
	exit
	elif [ $wybor == 5 ]
	then
		exec "./Instalka-do-wszystkiego.sh"
		exit
	fi
elif [ $wybor1 == 3 ]
then
	clear
	echo "1) Routing statyczny"
	sleep 0.1
	echo "2) Routing dynamiczny"
	sleep 0.1
	echo "3) Wlasna strona"
	sleep 0.1
	echo "4) powrot"
	sleep 0.4
	echo " "
	echo -n "Wybierz liczbe: "
	read wybor
		if [ $wybor == 1 ]
		then
			clear
			gio open https://arthurchiao.art/blog/play-with-container-network-if/ , https://aly.arriqaaq.com/linux-networking-bridge-iptables-and-docker/ 
		elif [ $wybor == 2 ]
		then
			clear
			xdg-open
		elif [ $wybor == 3 ]
		then
			clear
			echo -n "link: "
		read link
			xdg-open $link
		elif [ $wybor == 4 ]
		then
		exec "./Instalka-do-wszystkiego.sh"
		exit
		fi
	fi
else
	clear
	echo "Uruchom plik w katalogu domowym! (/home/$user) "
fi
