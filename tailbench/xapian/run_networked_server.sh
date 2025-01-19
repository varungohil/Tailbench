#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../configs.sh

# 必须要specify一下这个libxapian.so的位置，不然在启动程序时，它在通用的位置找不到它
export LD_LIBRARY_PATH=${TAILBENCH_ROOTDIR}/xapian/xapian-core-1.2.13/install/lib


NSERVERS=20
WARMUPREQS=2500
MAXREQS=5000

# Export environment variables first
export TBENCH_MAXREQS=${MAXREQS}
export TBENCH_WARMUPREQS=${WARMUPREQS}
export TBENCH_SERVER=10.0.1.1
export TBENCH_SERVER_PORT=12345
export TBENCH_NCLIENTS=1

chrt -f 99  ./xapian_networked_server -n ${NSERVERS} -d ${DATA_ROOT}/xapian/wiki -r 1000000000 
