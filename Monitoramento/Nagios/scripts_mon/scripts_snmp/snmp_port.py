#!/usr/bin/python

import socket
import sys
import time


if ( len(sys.argv) != 3 ):
    print "Usage: " + sys.argv[0] + " [IP]  [PORT] "
    sys.exit(1)


#VARIAVEL QUE ARMAZENA O IP
remote_host = sys.argv[1]
#VARIAVEL QUE ARMAZENA A PORTA
port = sys.argv[2]
#TRANSFORMANDO A VARIAVEL EM INTEIRO
port = int(port)


print "###### INICIO DO SCRIPT ######"
print "[IP] = " + remote_host + " [PORT] = " + str(port) 
print ""

#RESPONSAVEL POR PEGAR O TEMPO INICIAL DA CONEXAO DO SCRIPT
millis_inicio = int(round(time.time() * 1000))


#RESPONSAVEL POR TESTAR A CONEXAO
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.settimeout(3)
try:
	sock.connect((remote_host, port))
except Exception,e:
	print "RESULTADO DA CONEXAO, SE FOR 0 HOUVE ALGUM PROBLEMA"
	#print "%d closed " % port
	print "0" 
else:
	print "RESULTADO DA CONEXAO, SE FOR 0 HOUVE ALGUM PROBLEMA"
	#print "%d open" % port
	print "1" 
sock.close()


print ""
print ""



#RESPONSAVEL POR PEGAR O TEMPO FINAL DA CONEXAO DO SCRIPT
millis_fim = int(round(time.time() * 1000))

print "TEMPO EM MILISSEGUNDOS"
# RESPONSAVEL POR CALCULAR A QUANTIDADE DE MILISSEGUNDOS
time = ( millis_fim - millis_inicio)
print (time)


print ""
print "####### FIM DO SCRIPT #######"
