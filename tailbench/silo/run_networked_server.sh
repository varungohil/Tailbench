#!/bin/bash
# ops-per-worker is set to a very large value, so that TBENCH_MAXREQS controls how
# many ops are performed
NUM_WAREHOUSES=1
NUM_THREADS=1

QPS=1000
MAXREQS=50000
WARMUPREQS=20000

export TBENCH_MAXREQS=${MAXREQS} 
export TBENCH_WARMUPREQS=${WARMUPREQS} 
export TBENCH_SERVER=10.0.1.1 
export TBENCH_SERVER_PORT=12345 
export TBENCH_NCLIENTS=1 

chrt -f 99 ./out-perf.masstree/benchmarks/dbtest_server_networked --verbose --bench \
    tpcc --num-threads ${NUM_THREADS} --scale-factor ${NUM_WAREHOUSES} \
    --retry-aborted-transactions --ops-per-worker 10000000
