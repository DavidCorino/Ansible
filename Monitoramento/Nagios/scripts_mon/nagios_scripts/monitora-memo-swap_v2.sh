WARN=$1
CRIT=$2

memswap=`free -m | grep Swap | awk '{print $3}' | tail -n1`
memlivre=`free -m | grep Swap | awk '{print $4}' | tail -n1`
memtotal=`free -m | grep Swap | awk '{print $2}' | tail -n1`

porcentagemswap=`expr $memswap \* 100 / $memtotal`


if [ $porcentagemswap -lt "$WARN" ]; then
        echo "OK:  Memoria Swap em $memswap"Mb" [$porcentagemswap%] - [livre $memlivre"Mb"] [total $memtotal"Mb"]"
        exit 0
elif [ $porcentagemswap -ge "$WARN" -a $porcentagemswap -lt "$CRIT" ]; then
        echo "AVISO: Memoria Swap em $memswap"Mb" [$porcentagemswap%] - [livre $memlivre"Mb"] [total $memtotal"Mb"]"
        exit 1
elif [ $porcentagemswap -ge "$CRIT" ]; then
        echo "CRITICO:  Memoria Swap em $memswap"Mb" [$porcentagemswap%] - [livre $memlivre"Mb"] [total $memtotal"Mb"]"
        exit 2
else
       echo "DESCONHECIDO: Monitoramento pode ter falhado."
       exit 3
fi




