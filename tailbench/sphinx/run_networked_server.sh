#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

THREADS=20
WARMUPREQS=10
MAXREQS=25
AUDIO_SAMPLES='audio_samples'

LD_LIBRARY_PATH=./sphinx-install/lib:${LD_LIBRARY_PATH} \
    TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_SERVER=10.0.1.1 \
    TBENCH_SERVER_PORT=12345 \
    TBRNCH_NCLIENTS=1 \
    ./decoder_server_networked -t $THREADS
