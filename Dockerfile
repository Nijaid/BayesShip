# STAGE 0: Define paths and install final dependencies
FROM ghcr.io/bayescollab/bayesreqs:release AS base-build

ENV CPATH="/usr/local/include"
ENV LIBRARY_PATH="/usr/local/lib64:/usr/local/lib"
ENV LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib"

## PACKAGE INSTALL GUIDE ##
    # doxygen - Documentation system [RECOMMENDS: doxygen-latex]
    # nlohmann-json3-dev - JSON for C++ 
    # libarmadillo-dev - ARMA Linear ALgebra Library 
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq \
    nlohmann-json3-dev \
    libarmadillo-dev \
    doxygen \
    && rm -rf /var/lib/apt/lists/*

# STAGE 1: BayesShip
FROM base-build

# Copy all source files into new directory
WORKDIR /opt/BayesShip
COPY . .

WORKDIR /opt/BayesShip/build
# Configure the installation. Make sure the build directory is clean
RUN rm -rf * && cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../
# Compile and install the library
RUN make -j 4 install
WORKDIR /opt
RUN rm -rf /opt/BayesShip/