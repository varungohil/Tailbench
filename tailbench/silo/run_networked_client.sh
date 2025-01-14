#!/bin/bash
# ops-per-worker is set to a very large value, so that TBENCH_MAXREQS controls how
# many ops are performed

QPS=1000
MAXREQS=50000
WARMUPREQS=20000

TBENCH_QPS=${QPS} \
    TBENCH_WARMUPREQS=${WARMUPREQS} \
    TBENCH_MAXREQS=${MAXREQS} \
    TBENCH_MINSLEEPNS=100000 \
    TBENCH_RANDSEED=42 \
    TBENCH_CLIENT_THREADS=20 \
    TBENCH_SERVER=10.0.1.1 \
    TBENCH_SERVER_PORT=12345 \
    ./out-perf.masstree/benchmarks/dbtest_client_networked
