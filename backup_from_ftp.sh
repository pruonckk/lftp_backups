#!/bin/bash
#
# Script para copia de arquivos atraves de ftp 
# utilizando a aplicacao lftp 

USERNAME=FTP_USER
PASSWORD=FTP_PASS
HOST=ftp.server.com


# Aqui estamos buscando dentro da estrutura arquivos
# que ja constam numa estrutura de pasta, entao estamos buscando
# os ultimos 4 dias de informacao e criando a sincronizacao

for OFFSET in $(seq 1 4); do 
	ANO=$(date -j -v-${OFFSET}d +"%Y")
	MES=$(date -j -v-${OFFSET}d +"%m")
	DIA=$(date -j -v-${OFFSET}d +"%d")

	# Pasta de origem
	SOURCEFOLDER="/${ANO}/${MES}/${DIA}"

	# Pasta de destino (Modifique o caminho de acordo com 
	# a necessidade de seu ambiente 
	TARGETFOLDER="/mnt/STORAGE/SERVIDOR/${ANO}/${MES}/${DIA}"


	/mnt/STORAGE/jails/s3cmd/usr/local/bin/lftp -f "
open ${HOST}
user ${USERNAME} ${PASSWORD}
lcd ${SOURCEFOLDER}
mirror --verbose ${SOURCEFOLDER} ${TARGETFOLDER}
bye"


done
