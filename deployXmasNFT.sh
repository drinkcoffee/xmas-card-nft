#!/bin/bash

export RPC=
export PRIVKEY=
# Set to value 
export ALLOWLIST=

export ROLEADMIN=0x0E2D55943f4EF07c336C12A85d083c20FF189182
export MINTADMIN=0x0E2D55943f4EF07c336C12A85d083c20FF189182
export PAUSEADMIN=0x0E2D55943f4EF07c336C12A85d083c20FF189182
export BASEURI="https://github.com/drinkcoffee/xmas-card-nft/blob/main/card/It%20take%20a%20village%20to%20make%20a%20success%2C%20thank%20you.%20Long%20live%20mainnet!.png"
export CONTRACTURI="https://github.com/drinkcoffee/xmas-card-nft/"
export ROYALTYRECEIVER=0xE4A9125dB6A2E14459C7cF9670d702A73397551d
# 2000 means 20.00%
export ROYALTYFEE=2000


if [ -z "${PRIVKEY}" ]; then
    echo "PRIVKEY is unset or set to the empty string. Please: export PRIVKEY=<private key>"
    exit
fi

if [ -z "${RPC}" ]; then
    echo "RPC is unset or set to the empty string. Please: export RPC=<rpc>"
    exit
fi

if [ -z "${ROLEADMIN}" ]; then
    echo "ROLEADMIN is unset or set to the empty string. Please: export ROLEADMIN=<ROLEADMIN>"
    exit
fi

if [ -z "${MINTADMIN}" ]; then
    echo "MINTADMIN is unset or set to the empty string. Please: export MINTADMIN=<MINTADMIN>"
    exit
fi

if [ -z "${PAUSEADMIN}" ]; then
    echo "PAUSEADMIN is unset or set to the empty string. Please: export PAUSEADMIN=<PAUSEADMIN>"
    exit
fi

if [ -z "${ALLOWLIST}" ]; then
    echo "ALLOWLIST is unset or set to the empty string. Please: export ALLOWLIST=<ALLOWLIST>"
    exit
fi

if [ -z "${ROYALTYRECEIVER}" ]; then
    echo "ROYALTYRECEIVER is unset or set to the empty string. Please: export ROYALTYRECEIVER=<ROYALTYRECEIVER>"
    exit
fi

if [ -z "${ROYALTYFEE}" ]; then
    echo "ROYALTYFEE is unset or set to the empty string. Please: export ROYALTYFEE=<ROYALTYFEE>"
    exit
fi

echo "Deploying" 

forge create --rpc-url $RPC \
    --constructor-args $ROLEADMIN $MINTADMIN $PAUSEADMIN $BASEURI $CONTRACTURI $ALLOWLIST $ROYALTYRECEIVER $ROYALTYFEE\
    --private-key $PRIVKEY \
    src/XmasERC721.sol:XmasERC721
