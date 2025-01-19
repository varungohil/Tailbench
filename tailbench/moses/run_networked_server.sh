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
export TBENCH_MAXREQS=${MAXREQS}
export TBENCH_WARMUPREQS=${WARMUPREQS}
export TBENCH_WARMUPREQS=${WARMUPREQS}
export TBENCH_SERVER=10.0.1.1
export TBENCH_SERVER_PORT=12345
export TBENCH_NCLIENTS=1

chrt -f 99 ${BINDIR}/moses_server_networked -config ./moses.ini \
    -input-file ${DATA_ROOT}/moses/testTerms \
    -threads ${THREADS} -num-tasks 1000000 -verbose 0
