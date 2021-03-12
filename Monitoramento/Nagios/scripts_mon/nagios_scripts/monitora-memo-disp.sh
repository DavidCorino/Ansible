#!/bin/bash

WARN=$1
CRIT=$2


memusa=`free -m | grep Mem | awk '{print $3}' | tail -n1`
memlivre=`free -m | grep Mem | awk '{print $4}' | tail -n1`
memtotal=`free -m | grep Mem | awk '{print $2}' | tail -n1`
memcache=`free -m | grep Mem | awk '{print $6}' | tail -n1`

porcentagemcache=`expr $memcache \* 100 / $memtotal`
porcentagemusa=`expr $memusa \* 100 / $memtotal`
porcentagemlivre=`expr $memlivre \* 100 / $memtotal`


if [ $porcentagemlivre -gt "$WARN" ]; then
        echo "OK: Memoria disponivel em $memlivre"Mb" [$porcentagemlivre%] - [Uso $memusa"Mb" [$porcentagemusa%]] [Cache $memcache"Mb" [$porcentagemcache%]] [total $memtotal"Mb"]" 
        exit 0
elif [ $porcentagemlivre -le "$WARN" -a $porcentagemlivre -gt "$CRIT" ]; then
        echo "AVISO: Memoria disponivel em $memlivre"Mb" [$porcentagemlivre%] - [Uso $memusa"Mb" [$porcentagemusa%]] [Cache $memcache"Mb" [$porcentagemcache%]] [total $memtotal"Mb"]"
        exit 1
elif [ $porcentagemlivre -le "$CRIT" ]; then
        echo "CRITICO: Memoria disponivel em $memlivre"Mb" [$porcentagemlivre%] - [Uso $memusa"Mb" [$porcentagemusa%]] [Cache $memcache"Mb" [$porcentagemcache%]] [total $memtotal"Mb"]" 
        exit 2
else
       echo "DESCONHECIDO: Monitoramento pode ter falhado."
       exit 3
fi



