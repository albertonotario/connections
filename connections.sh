#!/bin/bash


#Alberto Notario - Terminales conectados al mismo segmento de red

trap ctrl_c INT #Manejo de interrupción CTRL+C 

function ctrl_c(){
	echo 'Saliendo del escaneo'
	killall connections.sh
}


echo 'Maquinas conectadas: '


for i in {1..254};	
do						
	 ping 192.168.1.$i -c1 -W 0.1  | grep "from" | cut -d ' ' -f 4
done

