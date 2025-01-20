#!/bin/bash

# Set build environment
export TBENCH_PATH=${PWD}/../harness
export CPATH=${TBENCH_PATH}${CPATH:+:$CPATH}

# Add thread-specific flags
./bjam toolset=gcc \
    define=WITH_THREADS \
    define=BOOST_HAS_PTHREADS \
    threading=multi \
    -j32 \
    -q || exit 1
