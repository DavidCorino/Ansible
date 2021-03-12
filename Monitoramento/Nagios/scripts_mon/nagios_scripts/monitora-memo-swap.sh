#memusa=`free -m | grep Swap | awk '{print $3}' | tail -n1`
memswap=`free -m | grep Swap | awk '{print $3}' | tail -n1`
memlivre=`free -m | grep Swap | awk '{print $4}' | tail -n1`

porcentagemswap=`expr $memswap \* 100 / $memtotal`

echo "$porcentagemswap"
if [ $memusa -lt "$1" ]; then
	echo "OK: Usado $memusa"Mb", livre $memlivre"Mb""
	exit 0
elif [ $memusa -ge "$1" -a $memusa -lt "$2" ]; then
	echo "AVISO: Usado $memusa"Mb", maior que $1"Mb" e menor que $2"Mb""
	exit 1
elif [ $memusa -ge "$2" ]; then
	echo "CRITICO: Usado $memusa"Mb", maior que $2"Mb""
	exit 2
else
	echo "DESCONHECIDO: Monitoramento por ter falhado."
exit 3
	fi
