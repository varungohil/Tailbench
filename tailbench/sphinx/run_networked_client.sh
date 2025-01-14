#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

QPS=5
WARMUPREQS=10
MAXREQS=25
AUDIO_SAMPLES='audio_samples'


TBENCH_QPS=1 \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_MINSLEEPNS=10000 \
    TBENCH_RANDSEED=42 \
    TBENCH_CLIENT_THREADS=20 \
    TBENCH_SERVER=10.0.1.1 \
    TBENCH_SERVER_PORT=12345 \
    TBENCH_AN4_CORPUS=${DATA_ROOT}/sphinx \
    TBENCH_AUDIO_SAMPLES=${AUDIO_SAMPLES} \
    ./decoder_client_networked &

echo $! > client.pid

wait $(cat client.pid)

# Cleanup
./kill_networked.sh
rm server.pid client.pid 