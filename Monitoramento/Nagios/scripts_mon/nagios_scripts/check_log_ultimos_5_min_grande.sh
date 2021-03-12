#!/bin/bash

#OBS- Script utilizado para grandes LOGS,o qual erros não costuma aparecer na linha da data.

LOG=$1
ERROR=$2
WARNING=$3
CRITICAL=$4
LINHA_FINAL=-999

#Linha da primeira ocorrencia de 5 minutos atras
LINHA5=$(cat $LOG | grep -n -m1 $(date +%H:%M: -d '-5 minutes')|cut -f1 -d ":")
LINHA4=$(cat $LOG | grep -n -m1 $(date +%H:%M: -d '-4 minutes')|cut -f1 -d ":")
LINHA3=$(cat $LOG | grep -n -m1 $(date +%H:%M: -d '-3 minutes')|cut -f1 -d ":")
LINHA2=$(cat $LOG | grep -n -m1 $(date +%H:%M: -d '-2 minutes')|cut -f1 -d ":")
LINHA1=$(cat $LOG | grep -n -m1 $(date +%H:%M: -d '-1 minutes')|cut -f1 -d ":")
LINHA0=$(cat $LOG | grep -n -m1 $(date +%H:%M:)|cut -f1 -d ":")


VALIDACAO () {
LINHA=$(expr $(cat $LOG | wc -l) - $LINHA_FINAL)


#Conta a quantidade de erros apartir da linha feita na verificacao acima
QUANT_ERROS=$(tail -n $LINHA $LOG | grep "$ERROR"| wc -l)

if [ $QUANT_ERROS -ge "$CRITICAL"  ]; then
        echo "CRITICAL: $QUANT_ERROS Total de erros em 5 minutos"
        exit 2
elif [ $QUANT_ERROS -ge "$WARNING" ] && [ $QUANT_ERROS -lt "$CRITICAL" ]; then
        echo "WARNING: $QUANT_ERROS Total de erros em 5 minutos"
        exit 1
elif [ $QUANT_ERROS -le "$WARNING" ]; then
        echo "OK: $QUANT_ERROS Total de erros em 5 minutos"
        exit 0
else
        echo "Desconhecido: Verificar Monitoramento"
        exit 3
fi
}

LINHA_5 (){
if [[ $LINHA5 -ne "" ]]; then
        LINHA_FINAL=$LINHA5
	VALIDACAO
else
 	LINHA_4
fi
}

LINHA_4 (){
if [[ $LINHA4 -ne "" ]]; then
        LINHA_FINAL=$LINHA4
	VALIDACAO
else
 	LINHA_3
fi
}

LINHA_3 (){
if [[ $LINHA3 -ne "" ]]; then
        LINHA_FINAL=$LINHA3
	VALIDACAO
else
 	LINHA_2
fi
}

LINHA_2 (){
if [[ $LINHA2 -ne "" ]]; then
        LINHA_FINAL=$LINHA2
	VALIDACAO
else
 	LINHA_1
fi
}

LINHA_1 (){
if [[ $LINHA1 -ne "" ]]; then
        LINHA_FINAL=$LINHA1
	VALIDACAO
else
 	LINHA_0
fi
}

LINHA_0 (){
if [[ $LINHA0 -ne "" ]]; then
        LINHA_FINAL=$LINHA0
	VALIDACAO
else
	echo "Nao houve incremento no log nos ultimos 5 minutos."
	exit 0
fi
}

LINHA_5

