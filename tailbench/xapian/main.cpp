#include <iostream>
#include <atomic>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <sched.h>
#include <sys/types.h>
#include "server.h"
#include "tbench_server.h"

using namespace std;

const unsigned long numRampUpReqs = 1000L;
const unsigned long numRampDownReqs = 1000L;
unsigned long numReqsToProcess = 1000L;
atomic_ulong numReqsProcessed(0);
pthread_barrier_t barrier;

inline void usage() {
    cerr << "xapian_search [-n <numServers>]\
        [-d <dbPath>] [-r <numRequests]" << endl;
}

inline void sanityCheckArg(string msg) {
    if (strcmp(optarg, "?") == 0) {
        cerr << msg << endl;
        usage();
        exit(-1);
    }
}

int main(int argc, char* argv[]) {
    unsigned numServers = 20;
    string dbPath = "db";

    int c;
    string optString = "n:d:r:";
    while ((c = getopt(argc, argv, optString.c_str())) != -1) {
        switch (c) {
            case 'n':
                sanityCheckArg("Missing #servers");
                numServers = atoi(optarg);
                break;

            case 'd':
                sanityCheckArg("Missing dbPath");
                dbPath = optarg;
                break;

            case 'r':
                sanityCheckArg("Missing #reqs");
                numReqsToProcess = atol(optarg);
                break;
            default:
                cerr << "Unknown option " << c << endl;
                usage();
                exit(-1);
                break;
        }
    }

    tBenchServerInit(numServers);

    Server::init(numReqsToProcess, numServers);
    Server** servers = new Server* [numServers];
    for (unsigned i = 0; i < numServers; i++) {
        servers[i] = new Server(i, dbPath);
    }
    // std::cout << "[SERVER] made server objects" << std::endl; 

    pthread_t* threads = NULL;
    if (numServers > 1) {
        threads = new pthread_t [numServers - 1];
        for (unsigned i = 0; i < numServers - 1; i++) {
            pthread_create(&threads[i], NULL, Server::run, servers[i]);
            cpu_set_t cpuset;
            CPU_ZERO(&cpuset);
            CPU_SET(i + 1, &cpuset);
            int rc = pthread_setaffinity_np(threads[i], sizeof(cpu_set_t), &cpuset);
            if (rc != 0) {
                cerr << "Error calling pthread_setaffinity_np: " << rc << endl;
            }
        }
    }

    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(0, &cpuset);
    pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);    

    Server::run(servers[numServers - 1]);

    if (numServers > 1) {
        for (unsigned i = 0; i < numServers - 1; i++)
            pthread_join(threads[i], NULL);
    }

    tBenchServerFinish();

    for (unsigned i = 0; i < numServers; i++)
        delete servers[i];

    Server::fini();

    return 0;
}
