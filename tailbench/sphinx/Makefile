CXX = g++
TBENCHDIR = ../harness
TBENCH_NETWORKED_SERVER_OBJS = $(TBENCHDIR)/tbench_server_networked.o
TBENCH_NETWORKED_CLIENT_OBJS = $(TBENCHDIR)/client.o \
                                                           $(TBENCHDIR)/tbench_client_networked.o
TBENCH_INTEGRATED_OBJS = $(TBENCHDIR)/client.o \
                                                 $(TBENCHDIR)/tbench_server_integrated.o
MODELDIR = /users/varuncg/Tailbench/tailbench/sphinx/sphinx-install/share/pocketsphinx/model
CXXFLAGS = -DMODELDIR=\"$(MODELDIR)\" \
                     `pkg-config --cflags --libs pocketsphinx sphinxbase` \
                         -I$(TBENCHDIR) -g -O3 -std=c++0x
LDFLAGS = -pthread -lrt
.PHONY : all clean run zsim
BINS = decoder_integrated decoder_server_networked decoder_client_networked
ROOTDIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LOCAL_PKG_CONFIG_PATH = $(ROOTDIR)/sphinx-install/lib/pkgconfig
LD_LIBRARY_PATH = $(ROOTDIR)/sphinx-install/lib
all : $(BINS)
decoder.o : decoder.cpp
         export PKG_CONFIG_PATH=$(LOCAL_PKG_CONFIG_PATH) && \
        $(CXX) `pkg-config --cflags pocketsphinx sphinxbase` -I $(ROOTDIR)/sphinx-install/include/sphinxbase -I $(ROOTDIR)/sphinx-install/include/pocketsphinx $< -c -o $@ $(CXXFLAGS)
client.o : client.cpp
        export PKG_CONFIG_PATH=$(LOCAL_PKG_CONFIG_PATH) && \
        $(CXX) `pkg-config --cflags pocketsphinx sphinxbase` \
        $< -c -o $@ $(CXXFLAGS)
decoder_integrated : client.o $(TBENCH_INTEGRATED_OBJS) decoder.o
        export PKG_CONFIG_PATH=$(LOCAL_PKG_CONFIG_PATH) && \
        $(CXX) $^ -o $@ `pkg-config --libs pocketsphinx sphinxbase` $(LDFLAGS)
decoder_server_networked : $(TBENCH_NETWORKED_SERVER_OBJS) decoder.o
        export PKG_CONFIG_PATH=$(LOCAL_PKG_CONFIG_PATH) && \
        $(CXX) $^ -o $@ `pkg-config --libs pocketsphinx sphinxbase` $(LDFLAGS) 
decoder_client_networked : client.o $(TBENCH_NETWORKED_CLIENT_OBJS)
        export PKG_CONFIG_PATH=$(LOCAL_PKG_CONFIG_PATH) && \
        $(CXX) $^ -o $@ `pkg-config --libs pocketsphinx sphinxbase` $(LDFLAGS)
clean:
		rm *.o
		rm $(BINS)