#!/bin/bash
LOG=$1
ERROR=$2
qtd_warning=$3
qtd_critico=$4

COUNT_TOTAL0=`tail -n 15000 $1 | grep "$2" | grep -v "Caused by" | grep "$(date +%H:%M)" | wc -l`
COUNT_TOTAL1=`tail -n 15000 $1 | grep "$2" | grep -v "Caused by" | grep "$(date +%H:%M -d '-1 minutes' )" | wc -l`
COUNT_TOTAL2=`tail -n 15000 $1 | grep "$2" | grep -v "Caused by" | grep "$(date +%H:%M -d '-2 minutes' )" | wc -l`
COUNT_TOTAL3=`tail -n 15000 $1 | grep "$2" | grep -v "Caused by" | grep "$(date +%H:%M -d '-3 minutes' )" | wc -l`
COUNT_TOTAL4=`tail -n 15000 $1 | grep "$2" | grep -v "Caused by" | grep "$(date +%H:%M -d '-4 minutes' )" | wc -l`
#COUNT_TOTAL5=`tail -n 15000 $1 | grep "$2" | grep -v "Caused by" | grep "$(date +%H:%M -d '-5 minutes' )" | wc -l`

COUNT_TOTAL=`expr $COUNT_TOTAL0 + $COUNT_TOTAL1 + $COUNT_TOTAL2 + $COUNT_TOTAL3 + $COUNT_TOTAL4`

if [ $COUNT_TOTAL -gt "$qtd_critico"  ]; then
  echo "CRITICO: $COUNT_TOTAL erros em 5 minutos"
  exit 2
elif [ $COUNT_TOTAL -ge "$qtd_warning" ]; then
  echo "AVISO: $COUNT_TOTAL erros em 5 minutos"
  exit 1 
elif [ $COUNT_TOTAL -eq "0" ]; then
  echo "OK: $COUNT_TOTAL Total de erros em 5 minutos"
  exit 0
else
 echo "Desconhecido: Verificar Monitoramento"
 exit 3
fi
