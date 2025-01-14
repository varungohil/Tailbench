#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

# 必须要specify一下这个libxapian.so的位置，不然在启动程序时，它在通用的位置找不到它
export LD_LIBRARY_PATH=/home/kernel_interference/tailbench/tailbench-v0.9/xapian/xapian-core-1.2.13/install/lib


NSERVERS=20
WARMUPREQS=2500
MAXREQS=5000

TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    ./xapian_networked_server -n ${NSERVERS} -d ${DATA_ROOT}/xapian/wiki \
    -r 1000000000 &

echo $! > server.pid
