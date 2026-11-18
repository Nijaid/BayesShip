FROM ghcr.io/bayescollab/bayesreqs:release

ENV CPATH="/usr/local/include"
ENV LIBRARY_PATH="/usr/local/lib64:/usr/local/lib"
ENV LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib"

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