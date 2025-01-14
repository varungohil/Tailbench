#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

THREADS=20
WARMUPREQS=5000
MAXREQS=5000

BINDIR=./bin

# Setup
cp moses.ini.template moses.ini
sed -i -e "s#@DATA_ROOT#$DATA_ROOT#g" moses.ini

# Launch Server
TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_SERVER=10.0.1.1 \
    TBENCH_SERVER_PORT=12345 \
    TBENCH_NCLIENTS=20 \
    ${BINDIR}/moses_server_networked -config ./moses.ini \
    -input-file ${DATA_ROOT}/moses/testTerms \
    -threads ${THREADS} -num-tasks 1000000 -verbose 0
