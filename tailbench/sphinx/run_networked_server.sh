#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

THREADS=20
WARMUPREQS=10
MAXREQS=25
AUDIO_SAMPLES='audio_samples'

export LD_LIBRARY_PATH=./sphinx-install/lib:${LD_LIBRARY_PATH} 
export TBENCH_MAXREQS=${MAXREQS} 
export TBENCH_WARMUPREQS=${WARMUPREQS} 
export TBENCH_SERVER=10.0.1.1 
export TBENCH_SERVER_PORT=12345 
export TBENCH_NCLIENTS=1 

chrt -f 99 ./decoder_server_networked -t $THREADS
