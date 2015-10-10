#!/bin/bash
racine=$(pwd)
profileTxt=profile.txt
profileTxtBackup=profile.txt.bak

install_prog_required(){
	echo  -e "\033[34m---------------------------\033[0m"
	echo  -e "\033[1;34mINSTALLATION ABOUT REQUIRED\033[0m"
	echo  -e "\033[34m---------------------------\033[0m"
	apt-get install -y iptables
	apt-get install -y git
	apt-get install -y wget
}


initialiaze_variable(){
	#preload l'ensemble des variables
	namevpn=MyVPNServer
	ipvpn=$(hostname -I)
	ippublicvpn=$(wget -qO- http://ipecho.net/plain ; echo);
	portvpn=443
	protovpn=tcp
	cryptvpn=2048
	countryvpn=US
	provincevpn=NY
	cityvpn=New-York
	orgvpn=OpenVPN
	ounvpn=N/A
	commonvpn=MyVPNServer
	mailvpn=mail@example.com
	ouvpn=N/A

	#init variable
	# allow to swich data for profile
	unset namevpn1
	unset ipvpn1
	unset ippublicvpn1
	unset portvpn1
	unset protovpn1
	unset cryptvpn1
	unset countryvpn1
	unset provincevpn1
	unset cityvpn1
	unset orgvpn1
	unset ounvpn1
	unset commonvpn1
	unset mailvpn1
	unset ouvpn1
}


install_prog_required
initialiaze_variable

ask_info(){
        echo  -e "\033[34m--------\033[0m"
        echo  -e "\033[1;34mREQUIRED!\033[0m"
        echo  -e "\033[34m--------\033[0m"
        echo  " "
	echo  -e "\033[1;34mNAME OF THE VPN ? (default : "$namevpn") \033[0m"
        read  namevpn1
        echo  -e "\033[1;34mPRIVATE IP ? (default : "$ipvpn") \033[0m "
        read  ipvpn1
        echo  -e "\033[1;34mPUBLIC IP ?(default : "$ippublicvpn") \033[0m"
        read  ippublicvpn1 
        echo  -e "\033[1;34mPROTOCOLE OF THE VPN ? ( default : "$protovpn") \033[0m"
        read  protovpn1 
        echo  -e "\033[1;34mPORT OF THE VPN ? ( default : "$portvpn") \033[0m"
        read  portvpn1
        echo  -e "\033[1;34mCRYPTAGE VPN IN BITS ( default : "$cryptvpn") \033[0m"
        read  cryptvpn1	



	echo   -e "\033[34m----------\033[0m"
        echo   -e "\033[1;34mOPTIONAL\033[0m"
        echo   -e "\033[34m----------\033[0m"
	echo   -e  "\033[1;32m IF YOU WANT , YOU CAN FILL IN EMPTY\033[0m"
	echo   -e "\033[1;34m(OPTIONAL) Your country in 2 caracteres ? (Default :"$countryvpn")\033[0m"
        read   countryvpn1 
	echo   -e "\033[1;34m(OPTIONAL) Your province in 2 caracteres ? (Default :"$provincevpn")\033[0m"
        read   provincevpn1
	echo   -e "\033[1;34m(OPTIONAL) Your city ? (Default :"$cityvpn") \033[0m"
        read   cityvpn1
	echo   -e "\033[1;34m(OPTIONAL) Your Organization Name ? (Default :"$orgvpn") \033[0m"
        read   orgvpn1
	echo   -e "\033[1;34m(OPTIONAL) Your organization unit name? (Default :"$ounvpn") \033[0m"
        read   ounvpn1
	echo   -e "\033[1;34m(OPTIONAL) Your common name? (Default :"$commonvpn") \033[0m"
        read   commonvpn1
	echo   -e "\033[1;34m(OPTIONAL) Your email address ? (Default :"$mailvpn") \033[0m"
        read   mailvpn1


	#replace init value with new value if different with the default value
	
	if [ "$namevpn1" != "" ]
	then
		namevpn=$namevpn1
	fi

	if [ "$ipvpn1" !=  "" ]
	then
		ipvpn=$ipvpn1
	fi
	
	if [ "$ippublicvpn1" !=  "" ]
	then
		ippublicvpn=$ippublicvpn1
	fi
	

	if [ "$protovpn1" !=  "" ]
	then
		protovpn=$protovpn1
	fi
	
	if [ "$portvpn1" != "" ]
	then
		portvpn=$portvpn1
	fi
	
	if [ "$cryptvpn1" != "" ]
	then
		cryptvpn=$cryptvpn1
	fi
	
	if [ "$countryvpn1" != "" ]
	then
		countryvpn=$countryvpn1
	fi
	
	if [ "$provincevpn1" != "" ]
	then
		provincevpn=$provincevpn1
	fi

	if [ "$cityvpn1" != "" ]
	then
		cityvpn=$cityvpn1
	fi
	
	if [ "$orgvpn1" != "" ]
	then
		orgvpn=$orgvpn1
	fi

	if [ "$commonvpn1" != "" ]
	then
		commonvpn=$commonvpn1
	fi

	if [ "$mailvpn1" != "" ]
	then
		mailvpn=$mailvpn1
	fi
}



ask_save_profil(){
	if [ ! -f $racine/$profileTxt ]; then
ask_info
cat <<EOF > $profileTxt
$namevpn
$ipvpn
$ippublicvpn
$protovpn
$portvpn
$cryptvpn
$countryvpn
$provincevpn
$cityvpn
$orgvpn
$ounvpn
$commonvpn
$mailvpn
EOF
		echo -e "\033[32m------------------------------\033[0m"
		echo -e "\033[1;32mPROFILE CREATED WITH SUCCESS\033[0m"
		echo -e "\033[32m------------------------------\033[0m"
cp $racine/$profileTxt $racine/$profileTxtBackup
	else
		echo " "
		echo " "
		echo  -e "\033[31m------------------------\033[0m"
		echo  -e "\033[1;31mA PROFIL ALREADY EXIST\033[0m"
		echo  -e "\033[31m------------------------\033[0m"
		echo " "
		echo " "
		
	fi
}

read_profile_file(){
	declare -a INFO
	while IFS='' read -r line || [[ -n "$line" ]]; do
		INFO+=($line)
	done < $profileTxt

	#load info in variable appropriate
	namevpn=${INFO[0]}
	ipvpn=${INFO[1]}
	ippublicvpn=${INFO[2]}
	protovpn=${INFO[3]}
	portvpn=${INFO[4]}
	cryptvpn=${INFO[5]}
	countryvpn=${INFO[6]}
	provincevpn=${INFO[7]}
	cityvpn=${INFO[8]}
	orgvpn=${INFO[9]}
	ounvpn=${INFO[10]}
	commonvpn=${INFO[11]}
	mailvpn=${INFO[12]}
}

show_profil(){
 #while there are something to read , we keep the data
	if [ -f $racine/$profileTxt ]; then
		read_profile_file
		echo " "
		echo " "
		echo -e "\033[34m-------------------------\033[0m"
		echo -e "\033[1;34mINFORMATONS ABOUT PROFILE\033[0m"
		echo -e "\033[34m-------------------------\033[0m"
		echo " "
		echo -e "\033[1;34mName : \033[0m"$namevpn
		echo -e "\033[1;34mIP private : \033[0m"$ipvpn
		echo -e "\033[1;34mIP Public : \033[0m"$ippublicvpn
		echo -e "\033[1;34mProtocol : \033[0m"$protovpn
		echo -e "\033[1;34mPort : \033[0m"$portvpn
		echo -e "\033[1;34mCryptage : \033[0m"$cryptvpn" bits"
		echo -e "\033[1;34mCountry certificat : \033[0m"$countryvpn
		echo -e "\033[1;34mProvince certificat : \033[0m"$provincevpn
		echo -e "\033[1;34mCity certificat : \033[0m"$cityvpn
		echo -e "\033[1;34mOrganization Name certificat : \033[0m"$orgvpn
		echo -e "\033[1;34mOrganization Unit Name certificat : \033[0m"$ounvpn
		echo -e "\033[1;34mCommon Name certificat : \033[0m"$commonvpn
		echo -e "\033[1;34mEmail certificat : \033[0m"$mailvpn
		echo " "
		echo " "

	else
		echo " "
		echo " "
		echo  -e "\033[31m------------------------\033[0m"
		echo  -e "\033[1;31mANY PROFILE CAN BE SHOWN\033[0m"
		echo  -e "\033[31m------------------------\033[0m"
		echo " "
		echo " "
		
	fi
}

delete_profil(){
	if [ -f $racine/$profileTxt ]; then
		rm $racine/$profileTxt

		initialiaze_variable

		echo " "
		echo " "
		echo  -e "\033[32m----------------------------\033[0m"
		echo  -e "\033[1;32mPROFILE DELETED WITH SUCCESS\033[0m"
		echo  -e "\033[32m----------------------------\033[0m"
		echo " "
		echo " "
		
	else
		echo " "
		echo " "
		echo -e "\033[31m--------------------------\033[0m"
		echo -e "\033[1;31mANY PROFILE CAN BE DELETED\033[0m"
		echo -e "\033[31m--------------------------\033[0m"
		echo " "
		echo " "
		
	fi
}

restore_profil(){
	if [ -f $racine/$profileTxtBackup ]; then
		cp $racine/$profileTxtBackup $racine/$profileTxt
		echo " "
		echo " "		
		echo  -e "\033[32m-----------------------------\033[0m"
		echo  -e "\033[1;32mPROFILE RESTORED WITH SUCCESS\033[0m"
		echo  -e "\033[32m-----------------------------\033[0m"
		echo " "
		echo " "
	else
		echo " "
		echo " "
		echo -e "\033[31m---------------------------\033[0m"
		echo -e "\033[1;31mANY PROFILE CAN BE RESTORED\033[0m"
		echo -e "\033[31m---------------------------\033[0m"
		echo " "
		echo " "

	fi
}

loop=0
#install programs required
#install_prog_required
until [ $loop -eq 1 ]
do
	reponse=0
	until [ $reponse -gt 0 > /dev/null 2>&1 ] && [ $reponse -lt 7 > /dev/null 2>&1 ]; do
	echo  -e "\033[34m-----------------------\033[0m"
	echo  -e "\033[1;34mINSTALLATION VPN/CLIENT\033[0m"
	echo  -e "\033[34m-----------------------\033[0m"
	echo  " "
	echo " 1- To create the server VPN"
	echo " 2- To create a client VPN"
	echo " "
	echo -e "\033[34m------------------------\033[0m"
	echo " "
	echo " 3- To create the server profile"
	echo " 4- To show the server profile"
	echo " 5- To delete the server profile"
	echo " 6- To restore the last server profile"
	echo " "
	echo -e "\033[34m------------------------\033[0m"
	echo "To Exit : CTRL-C"
	echo "Write the number option please"
	read reponse
	done

	case "$reponse" in

	  "1" )
		until [ $profile -gt 0 > /dev/null 2>&1 ] && [ $profile -lt 3 > /dev/null 2>&1 ]; do
		echo  -e "\033[34m--------------\033[0m"
		echo  -e "\033[1;34mLOAD PROFILE ?\033[0m"
		echo  -e "\033[34m--------------\033[0m"
		echo  " "
		echo " 1- To load the save profile"
		echo " 2- To create a server VPN without profile"
		echo " 3- To Exit / Pour quitter : CTRL-C"
		echo "Write the number option please"
		read profile
		done

		case "$profile" in
		"1" )
			if [ -f $racine/$profileTxt ]
			then
				read_profile_file

			else
				echo -e "\033[31m----------------\033[0m"
				echo -e "\033[1;31mNO PROFILE FOUND\033[0m"
				echo -e "\033[31m----------------\033[0m"
				ask_info
			fi
		;;

		"2" )
			ask_info
			loop=1
		;;
		esac

		#install new version of openvpn
		apt-get install -y openvpn

	  	#update and upgrade to install new dependances and librairies
		apt-get update
		apt-get upgrade -y

		#cd ./scriptVPN_linux
		mkdir /etc/openvpn/easyrsa3
		mv /easyrsa3/* /etc/openvpn/easyrsa3
		cd /etc/openvpn/easyrsa3
		cp vars.example vars

		# edit the file /etc/openvpn/easy-rsa/vars
		sed -i.bak 's/#set_var EASYRSA=".*"/set_var EASYRSA="\/etc\/openvpn\/easyrsa3"/i' /etc/openvpn/easyrsa3/vars;

		#edit vars and put the number cryptage of the key
		sed -i.bak 's/#set_var EASYRSA_KEY_SIZE=.*/set_var EASYRSA_KEY_SIZE='$cryptvpn'/i' /etc/openvpn/easyrsa3/vars;

		sed -i.bak 's/#set_var EASYRSA_REQ_COUNTRY=.*/set_var EASYRSA_REQ_COUNTRY="'$countryvpn'"/i' /etc/openvpn/easyrsa3/vars;
		sed -i.bak 's/#set_var EASYRSA_REQ_PROVINCE=.*/set_var EASYRSA_REQ_PROVINCE="'$provincevpn'"/i' /etc/openvpn/easyrsa3/vars;
		sed -i.bak 's/#set_var EASYRSA_REQ_CITY=.*/set_var EASYRSA_REQ_CITY="'$cityvpn'"/i' /etc/openvpn/easyrsa3/vars;
		sed -i.bak 's/#set_var EASYRSA_REQ_ORG=.*/set_var EASYRSA_REQ_ORG="'$orgvpn'"/i' /etc/openvpn/easyrsa3/vars;
		sed -i.bak 's/#set_var EASYRSA_REQ_EMAIL=.*/set_var EASYRSA_REQ_EMAIL="'$mailvpn'"/i' /etc/openvpn/easyrsa3/vars;
		sed -i.bak 's/#set_var EASYRSA_REQ_OU=.*/set_var EASYRSA_REQ_OU="'$ounvpn'"/i' /etc/openvpn/easyrsa3/vars;

		# build CA certificate and root ca certificate
		./easyrsa init-pki
		./easyrsa build-ca
		
		#Generate Diffie-Hellman key exchange
		./easyrsa build-server-full <$namevpn> [nopass]

		#move file in /etc/openvpn
		cp pki/ca.crt /etc/openvpn
		cp pki/private/$namevpn.key /etc/openvpn
		cp pki/issued/$namevpn.crt /etc/openvpn
		cp pki/reqs/$namevpn.req /etc/openvpn

		#generate  Diffie-Hellman
		./easyrsa gen-dh

		#move file in /etc/openvpn
		cp pki/dh.pem /etc/openvpn

		#create server.conf
cat <<EOF > /etc/openvpn/server.conf
port $portvpn
proto $protovpn
dev tun
comp-lzo
persist-key
persist-tun
keepalive 10 20
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
ca ca.crt 
cert $namevpn.crt
key $namevpn.key
dh dh.pem
status openvpn-status.log
verb 3
EOF

		# add TUN/TAP if desabled
		mkdir -p /dev/net
		mknod /dev/net/tun c 10 200

		#uncomment the line : ipv4.ip_forward=1
		sed -i.bak 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/i' /etc/sysctl.conf;

		#This command configures kernel parameters at runtime. The -p tells it to reload the file with the changes you just made.
		sysctl -p
		/etc/init.d/networking reload


		# We still want the firewall to protect us from most incoming and outgoing network traffi
cat <<EOF > /etc/firewall.rules
*nat
:PREROUTING ACCEPT
:INPUT ACCEPT
:OUTPUT ACCEPT
:POSTROUTING ACCEPT
-A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
-A POSTROUTING -o eth0 -j MASQUERADE
COMMIT
*filter
:INPUT ACCEPT
:FORWARD DROP
:OUTPUT ACCEPT
-A FORWARD -i eth0 -o tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i tun0 -o eth0 -j ACCEPT
COMMIT
EOF
	chmod 755 /etc/firewall.rules

cat <<EOF > /etc/init.d/firewall
#!/bin/sh
/sbin/iptables-restore /etc/firewall.rules
EOF

	chmod 755 /etc/init.d/firewall
	#Et on indique au système que ce script doit être lancé automatiquement au démarrage du système
	update-rc.d firewall defaults

	#restart service
	service openvpn start

	#initialize the config for client
	cd /etc/openvpn/easyrsa3
	source vars

cat <<EOF > /etc/openvpn/Default.txt
client
dev tun
proto $protovpn
remote $ippublicvpn $portvpn
EOF

	cp  $racine/makeOVPN.sh /etc/openvpn/
	chmod 777 -R /etc/openvpn

	#reboot to finish to install some last things	
	service openvpn restart

	  ;;

	  "2" )
	  	echo  -e "\033[34m--------------\033[0m"
		echo  -e "\033[1;34mRENSEIGNEMENTS\033[0m"
		echo  -e "\033[34m--------------\033[0m"
		echo  "Name of the client ?"
		read -e -p "$nameclient" nameclient

		#build the  key  but without pass
		cd /etc/openvpn/easyrsa3/
		source ./vars
		./easyrsa build-client-full <$nameclient> [nopass]

		# start the script to create the client
		cd /etc/openvpn
		./makeOVPN.sh
		chmod 777 -R /etc/openvpn

		loop=1
	  ;;

	  "3" )
		ask_save_profil
	  ;;

	  "4" )
		show_profil
	  ;;

	  "5" )
		delete_profil
	  ;;

	 "6" )
		restore_profil
	  ;;

	esac
done
exit

