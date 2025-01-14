#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

# 必须要specify一下这个libxapian.so的位置，不然在启动程序时，它在通用的位置找不到它
export LD_LIBRARY_PATH=/home/kernel_interference/tailbench/tailbench-v0.9/xapian/xapian-core-1.2.13/install/lib

QPS=50
WARMUPREQS=2500
MAXREQS=5000

TBENCH_QPS=${QPS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_MINSLEEPNS=100000 \
    TBENCH_RANDSEED=42 \
    TBENCH_CLIENT_THREADS=20 \
    TBENCH_SERVER=10.0.1.1 \
    TBENCH_SERVER_PORT=12345 \
    TBENCH_TERMS_FILE=${DATA_ROOT}/xapian/terms.in \
    ./xapian_networked_client
