#!/bin/bash

NOME=$1

CONTAGEM=$(ps -ef | grep $NOME 2> /dev/null | grep -v grep  2> /dev/null | grep -v snmp_processo 2> /dev/null | wc -l)

echo "###### INICIO DO SCRIPT ######"
echo ""
echo "Nome do Processo"
echo "$NOME"
echo ""
echo ""
echo "Quantidade de Processos em Execucao com a string '$NOME'"
echo "$CONTAGEM"
echo ""
echo "####### FIM DO SCRIPT #######"


