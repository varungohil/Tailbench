#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

QPS=100
WARMUPREQS=5000
MAXREQS=5000

BINDIR=./bin

# Setup
cp moses.ini.template moses.ini
sed -i -e "s#@DATA_ROOT#$DATA_ROOT#g" moses.ini

# Launch Client
TBENCH_QPS=${QPS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_MINSLEEPNS=10000 \
    TBENCH_RANDSEED=42 \
    TBENCH_CLIENT_THREADS=20 \
    TBENCH_SERVER=10.0.1.1 \
    TBENCH_SERVER_PORT=12345 \
    ${BINDIR}/moses_client_networked
