#!/bin/bash

WARN=$1
CRIT=$2

memusa=`free -m | grep Mem | awk '{print $3}' | tail -n1`
memlivre=`free -m | grep Mem | awk '{print $4}' | tail -n1`
memtotal=`free -m | grep Mem | awk '{print $2}' | tail -n1`

memcache=`free -m | grep Mem | awk '{print $6}' | tail -n1`

porcentagemcache=`expr $memcache \* 100 / $memtotal`

porcentagemusa=`expr $memusa \* 100 / $memtotal`


if [ $porcentagemcache -lt "$WARN" ]; then
        echo "OK:  Memoria Chache em $memcache"Mb" [$porcentagemcache%] - [Usado $memusa"Mb" [$porcentagemusa%]] [livre $memlivre"Mb"] [total $memtotal"Mb"]"
	exit 0
elif [ $porcentagemcache -ge "$WARN" -a $porcentagemcache -lt "$CRIT" ]; then
        echo "AVISO: Memoria Chache em $memcache"Mb" [$porcentagemcache%] - [Usado $memusa"Mb" [$porcentagemusa%]] [livre $memlivre"Mb"] [total $memtotal"Mb"]"
        exit 1
elif [ $porcentagemcache -ge "$CRIT" ]; then
        echo "CRITICO:  Memoria Chache em $memcache"Mb" [$porcentagemcache%] - [Usado $memusa"Mb" [$porcentagemusa%]] [livre $memlivre"Mb"] [total $memtotal"Mb"]"
	exit 2
else
       echo "DESCONHECIDO: Monitoramento pode ter falhado."
       exit 3
fi


