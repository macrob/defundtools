#!/bin/bash
WALLET=general
PASWD='password'

CHAIN=defund-private-1
PROJECT=defundd
TOKEN_NAME=ufetf

DELEGATOR=$(echo -e "${PASWD}" | $PROJECT keys show $WALLET -a)
VALIDATOR=$(echo -e "${PASWD}\n${PASWD}\n" | $PROJECT keys show $WALLET --bech val -a)
ACC_NAME=$WALLET

DELAY=300
NODE=http://localhost:26657

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo $DELEGATOR
echo $VALIDATOR
echo $ACC_NAME

for (( ;; )); do
        BAL=$(${PROJECT} query bank balances ${DELEGATOR} --node ${NODE});
        echo -e "BALANCE: ${GREEN}${BAL}${NC} ${TOKEN_NAME}\n"
        echo -e "Claim rewards\n"
        echo -e "${PASWD}\n${PASWD}\n" | ${PROJECT} tx distribution withdraw-rewards ${VALIDATOR} --chain-id ${CHAIN} --from ${ACC_NAME} --node ${NODE} --commission -y --fees 200${TOKEN_NAME}
        for (( timer=10; timer>0; timer-- ))
        do
                printf "* sleep for ${RED}%02d${NC} sec\r" $timer
                sleep 1
        done
        BAL=$(${PROJECT} query bank balances ${DELEGATOR} --node ${NODE} -o json | jq -r '.balances | .[1].amount');
        BAL=$((BAL-1000000));
         echo -e "BALANCE: ${GREEN}${BAL}${NC} ${TOKEN_NAME}\n"
         echo -e "Stake ALL\n"
         echo -e "${PASWD}\n${PASWD}\n" | ${PROJECT} tx staking delegate ${VALIDATOR} ${BAL}${TOKEN_NAME} --chain-id ${CHAIN} --from ${ACC_NAME} --node ${NODE} -y --fees  200${TOKEN_NAME}
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED}%02d${NC} sec\r" $timer
                sleep 1
        done
done