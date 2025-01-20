#include <unistd.h>

#include <algorithm>
#include <fstream>
#include <iostream>
#include <mutex>
#include <random>
#include <string>
#include <thread>
#include <vector>
#include <pthread.h>
#include "internal.h"
#include "tbench_server.h"
#include <pocketsphinx.h>
#include <err.h>

void doAsr() {
    tBenchServerThreadStart();

    err_set_logfp(NULL); // Get sphinx to be quiet
    ps_decoder_t *ps;
    cmd_ln_t *config;
    FILE *fh;
    char const *hyp, *uttid;
    int64_t bufsize = 1024*1024;
    int16* buf = nullptr;
    int rv;
    int32 score;
    std::cout << "in doAsr()" << std::endl;

    config = cmd_ln_init(NULL, ps_args(), TRUE,
                 "-hmm", "/users/varuncg/Tailbench/tailbench/sphinx/sphinx-install/share/pocketsphinx/model/en-us/en-us",
                 "-lm", "/users/varuncg/Tailbench/tailbench/sphinx/sphinx-install/share/pocketsphinx/model/en-us/en-us.lm.bin",
                 "-dict", "/users/varuncg/Tailbench/tailbench/sphinx/sphinx-install/share/pocketsphinx/model/en-us/cmudict-en-us.dict",
                 NULL);
    std::cout << "got config" << std::endl;
    if (config == NULL) throw AsrException("Could not init config");
    std::cout << "calling ps_init()" << std::endl;
    ps = ps_init(config);
    std::cout << "done with ps_init()" << std::endl;
    if (ps == NULL) throw AsrException("Could not init pocketsphinx");

    while (true) {
        size_t len = tBenchRecvReq(reinterpret_cast<void**>(&buf));

        rv = ps_start_utt(ps);
        if (rv < 0) throw AsrException("Could not start utterance");

        int16* cur = buf;
        int64_t remaining = len / sizeof(int16);

        while (remaining > 0) {
            size_t nsamp = std::min(remaining, bufsize);
            rv = ps_process_raw(ps, cur, nsamp, FALSE, FALSE);

            cur += nsamp;
            remaining -= nsamp;
        }

        rv = ps_end_utt(ps);
        if (rv < 0) throw AsrException("Could not end utterance");

        hyp = ps_get_hyp(ps, &score);
        if (hyp == NULL) AsrException("Could not get hypothesis");

        tBenchSendResp(reinterpret_cast<const void*>(hyp), strlen(hyp), len, 0, 0);
    }

    ps_free(ps);
    cmd_ln_free_r(config);
};

void usage() {
    std::cerr << "Usage: decoder [-t nthreads]" << std::endl;
}

int main(int argc, char *argv[])
{
    int nthreads = 20;
    std::cout << "in main()" << std::endl;

    int c;
    while((c = getopt(argc, argv, "t:")) != EOF) {
        switch(c) {
            case 't':
                nthreads = atoi(optarg);
                break;
            case '?':
                usage();
                return -1;
                break;
        }
    }

    std::vector<std::thread> threads;

    std::cout << "tBenchServerInit" << std::endl;
    tBenchServerInit(nthreads);

    for (int i = 0; i < nthreads; i++) {
        std::cout << "creating thread " << i << std::endl;
        threads.push_back(std::thread([i]() {
            // Create CPU set for thread affinity
            cpu_set_t cpuset;
            CPU_ZERO(&cpuset);
            CPU_SET(i, &cpuset);
            
            // Pin the current thread to core i
            int rc = pthread_setaffinity_np(pthread_self(),
                                          sizeof(cpu_set_t), &cpuset);
            if (rc != 0) {
                std::cerr << "Error calling pthread_setaffinity_np: " << rc << std::endl;
            }
            
            doAsr();
        }));
    }

    // never reached
    for (auto& th : threads) th.join();

    tBenchServerFinish();

    return 0;
}
