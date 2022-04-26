#!/bin/bash

TOKEN_NAME=ufetf
PROJECT=defundd

URL='http://146.190.235.132:8000/'

PASWD='password'

addrList=$(yq '.[].address' keys/list.txt)


for walletAddr in $addrList; do
   
    generate_post_data()
    {
    cat <<EOF
{
    "address": "$walletAddr",
    "coins": ["100000000${TOKEN_NAME}"]
}
EOF
    }

    echo $walletAddr;
    echo $(generate_post_data);
    echo $URL;

    curl -X POST -d "$(generate_post_data)" $URL
done

