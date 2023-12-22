#!/bin/bash

export RPC=
export PRIVKEY=

export ROLEADMIN=0x0E2D55943f4EF07c336C12A85d083c20FF189182

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

echo "Deploying" 

forge create --rpc-url $RPC \
    --constructor-args $ROLEADMIN \
    --private-key $PRIVKEY \
    src/allowlist/OperatorAllowlist.sol:OperatorAllowlist
