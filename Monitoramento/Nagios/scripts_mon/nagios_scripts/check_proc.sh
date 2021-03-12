#!/bin/bash
# 
# Plugin to check processes running
# using check_by_ssh
# by Markus Walther (voltshock@gmx.de)
# The script needs a working check_by_ssh connection and needs to run on the client to check it
# 
# Command-Line for check_by_ssh
# command_line    $USER1$/check_by_ssh -H $HOSTNAME$ -p $ARG1$ -C "$ARG2$ $ARG3$ $ARG4$ $ARG5$ $ARG6$"
# 
# Command-Line for service (example)
# check_by_ssh!82!/nagios/check_proc.sh!sshd!1!10
#
##########################################################
case $1 in
  --help | -h )
        echo "Uso: check_proc [proc] [min] [max]"
        echo " [min] and [max] as int"
        echo " Exemplo: check_proc sshd 1 5"
         exit 3
         ;;
  * )
    ;;
esac

if [ ! "$1" -o ! "$2" -o ! "$3" ]; then
        echo "Uso: check_proc [proc] [min] [max]"
        echo " [min] and [max] as int"
        echo " Exemplo: check_proc sshd 1 5"
        echo "Unknown: Options missing"
        exit 3
fi

if [ "$2" -gt "$3" ]; then
        echo "Unknown: [max] must be larger than [min]"
        exit 3
fi

proc=$1
min=$2
max=$3
lines=`ps -ef | grep "$proc" | grep -v grep | grep -v check_proc | wc -l`

if [ "$lines" -eq "$min" -o "$lines" -gt "$min" ]; then
        if [ "$lines" -lt "$max" -o "$lines" -eq "$max" ]; then
                echo "OK: $lines processos rodando (min=$min, max=$max)"
                exit 0
         else
                echo "Warning: Varios processos rodando ($lines/$max)"
                exit 1
        fi
 elif [ "$lines" -lt "$min" ]; then
        echo "Critical: Nao ha o minimo de processos rodando ($lines/$min)"
        exit 2
 else
        echo "Erro Desconhecido: possivel falha no monitoramento"
        exit 3
fi

