#!/bin/bash
TOKEN_NAME=ufetf
PROJECT=defundd

PASWD='password'


i=10
while [ $i -ne 100 ]
do
        i=$(($i+1))
        
        echo -e "${PASWD}\n${PASWD}\n" | ${PROJECT} keys add $i >> keys/list.txt
done

