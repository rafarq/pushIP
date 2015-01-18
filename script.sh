#!/bin/bash
#Autor/Author: Rafael Roa
#Script para enviar un mensaje mediante PushOver con la ip externa del router cada vez que cambie.
#Get a push notification via PushOver when your computer changes its public IP.

#CONFIGURATION
#CONFIGURACION
Path='/home/pi/'

#Se comprueba cual es la ip actual
#We check the current ip
IP=$(curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//')

echo La ip actual es "$IP"

#The old ip is retrieved
#Se recupera la ip anterior que está almacenada en el archivo currentIP.txt
oldIP=`cat "$Path"currentIP.txt`
echo La ip anterior era "$oldIP"

#We compare the old and the new ip
#Se comparan las dos IPs para ver si son iguales
if [ $IP = $oldIP ]
then
#there is nothing to do
#no es necesario hacer nada
echo Son iguales


else
#We send a notification	
#se envía una notificación usando pushover
echo No son iguales
curl -s \
  --form-string "token=yourTOKEN" \
  --form-string "user=yourUSER" \
  --form-string "message=la nueva IP es $IP" \
  https://api.pushover.net/1/messages.json
echo "$IP" > $Path"currentIP.txt"
fi
