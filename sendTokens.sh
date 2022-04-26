#!/bin/bash

TOKEN_NAME=ufetf
PROJECT=defundd

MAINADDRESS='ADDRESSKUDSLIVAT'
PASWD='password'

addrList=$(yq '.[].address' keys/list.txt)


for walletAddr in $addrList; do
   
    echo -e "${PASWD}\n${PASWD}\n" | ${PROJECT} tx bank send ${walletAddr} ${MAINADDRESS} 99000000${TOKEN_NAME} -y
done