#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

QPS=5
WARMUPREQS=10
MAXREQS=25
AUDIO_SAMPLES='audio_samples'


export TBENCH_QPS=1 
export TBENCH_WARMUPREQS=${WARMUPREQS} 
export TBENCH_MAXREQS=${MAXREQS} 
export TBENCH_MINSLEEPNS=10000 
export TBENCH_RANDSEED=42 
export TBENCH_CLIENT_THREADS=20 
export TBENCH_SERVER=10.0.1.1 
export TBENCH_SERVER_PORT=12345 
export TBENCH_AN4_CORPUS=${DATA_ROOT}/sphinx 
export TBENCH_AUDIO_SAMPLES=${AUDIO_SAMPLES} 

chrt -f 99 ./decoder_client_networked
