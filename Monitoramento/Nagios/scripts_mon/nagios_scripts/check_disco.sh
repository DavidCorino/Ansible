#!/bin/ksh

particao="$1"
perc_uso_disco=`df -g | grep "$particao" | cut -d% -f1 | awk '{print $4}'`
perc_liv_disco=`expr 100 - $perc_uso_disco`
mb_liv_disco=` df -m | grep $particao | cut -d. -f2 | awk '{print $2}'`

if [ $perc_uso_disco -lt "80" ]; then
  echo "DISK OK - free space: $particao $mb_liv_disco MB ($perc_liv_disco% livre)" 
  exit 0 
elif [ $perc_uso_disco -ge "80" -a $perc_uso_disco -lt "90" ]; then
  echo "DISK AVISO - free space: $particao $mb_liv_disco MB ($perc_liv_disco% livre)" 
  exit 1 
elif [ $perc_uso_disco -ge "90" ]; then
  echo "DISK CRITICO - free space: $particao $mb_liv_disco MB ($perc_liv_disco% livre)" 
  exit 2 
else
  echo "DISK DESCONHECIDO - Falha ao executar o Monitoramento" 
  exit 3 
fi
