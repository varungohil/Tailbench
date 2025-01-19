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
export TBENCH_QPS=${QPS} 
export TBENCH_WARMUPREQS=${WARMUPREQS} 
export TBENCH_MAXREQS=${MAXREQS} 
export TBENCH_MINSLEEPNS=10000 
export TBENCH_RANDSEED=42 
export TBENCH_CLIENT_THREADS=20 
export TBENCH_SERVER=10.0.1.1 
export TBENCH_SERVER_PORT=12345 

chrt -f 99 ${BINDIR}/moses_client_networked
