#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

# 必须要specify一下这个libxapian.so的位置，不然在启动程序时，它在通用的位置找不到它
export LD_LIBRARY_PATH=/home/kernel_interference/tailbench/tailbench-v0.9/xapian/xapian-core-1.2.13/install/lib

QPS=50
WARMUPREQS=2500
MAXREQS=5000

export TBENCH_QPS=${QPS} 
export TBENCH_WARMUPREQS=${WARMUPREQS} 
export TBENCH_MAXREQS=${MAXREQS} 
export TBENCH_MINSLEEPNS=100000 
export TBENCH_RANDSEED=42 
export TBENCH_CLIENT_THREADS=20 
export TBENCH_SERVER=10.0.1.1 
export TBENCH_SERVER_PORT=12345 
export TBENCH_TERMS_FILE=${DATA_ROOT}/xapian/terms.in

chrt -f 99 ./xapian_networked_client
