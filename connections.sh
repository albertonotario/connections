#!/bin/bash


#Alberto Notario - Terminales conectados al mismo segmento de red

trap ctrl_c INT #Manejo de interrupción CTRL+C 

function ctrl_c(){
	echo -e '\nSaliendo del escaneo'
	killall connections.sh
}

function whichOS(){
	case $ttl in
		64)
			echo 'Linux/Unix'
		;;
		128)
			echo 'Windows'
		;;
		254)
			echo 'Solaris'
		;;
		*)
			echo 'N/A'
		;;
	esac

}


init_time=$(date +%s)

echo 'Maquinas conectadas'
echo '-------------------'

for i in {1..254};	
do						
	ttl=$(ping 192.168.1.$i -c1 -W 0.1  | grep "from" | cut -d ' ' -f 6 | cut -c 5-)
	machine=$(ping 192.168.1.$i -c1 -W 0.1  | grep "from" | cut -d ' ' -f 4) 
	if [[ $(whichOS) != 'N/A' ]]
	then
		fin_time=$(date +%s) 
		op_time=$((($fin_time-$init_time)))
		echo  $machine'-------->'$(whichOS)'---->'$op_time' segundos'
	fi
done

killall connections.sh
