#!/bin/bash
# ops-per-worker is set to a very large value, so that TBENCH_MAXREQS controls how
# many ops are performed

QPS=1000
MAXREQS=50000
WARMUPREQS=20000

export TBENCH_QPS=${QPS} 
export TBENCH_WARMUPREQS=${WARMUPREQS} 
export TBENCH_MAXREQS=${MAXREQS} 
export TBENCH_MINSLEEPNS=100000 
export TBENCH_RANDSEED=42 
export TBENCH_CLIENT_THREADS=20 
export TBENCH_SERVER=10.0.1.1 
export TBENCH_SERVER_PORT=12345 

chrt -f 99 ./out-perf.masstree/benchmarks/dbtest_client_networked
