#!/bin/bash


memusa=`free -m | grep Mem | awk '{print $3}' | tail -n1`
memlivre=`free -m | grep Mem | awk '{print $4}' | tail -n1`
memtotal=`free -m | grep Mem | awk '{print $2}' | tail -n1`

if [ $memusa -lt "$1" ]; then
        echo "OK: Usado $memusa"Mb", livre $memlivre"Mb", total $memtotal"Mb""
	 exit 0
 elif [ $memusa -ge "$1" -a $memusa -lt "$2" ]; then
              echo "AVISO: Usado $memusa"Mb", maior que $1"Mb" e menor que $2"Mb""
                exit 1
               elif [ $memusa -ge "$2" ]; then
                 echo "CRITICO: Usado $memusa"Mb", maior que $2"Mb""
		 exit 2
	else
       echo "DESCONHECIDO: Monitoramento pode ter falhado."
       exit 3
       fi
