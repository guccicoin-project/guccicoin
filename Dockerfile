# daemon runs in the background
# run something like tail /var/log/guccicoind/current to see the status
# be sure to run with volumes, ie:
# docker run -v $(pwd)/guccicoind:/var/lib/guccicoind -v $(pwd)/wallet:/home/guccicoin --rm -ti guccicoin:0.2.2
ARG base_image_version=0.10.0
FROM phusion/baseimage:$base_image_version

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ADD https://github.com/just-containers/socklog-overlay/releases/download/v2.1.0-0/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /

ARG GUCCICOIN_BRANCH=master
ENV GUCCICOIN_BRANCH=${GUCCICOIN_BRANCH}

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      python-dev \
      gcc-4.9 \
      g++-4.9 \
      git cmake \
      libboost1.58-all-dev && \
    git clone https://github.com/guccicoin-project/guccicoin.git /src/guccicoin && \
    cd /src/guccicoin && \
    git checkout $GUCCICOIN_BRANCH && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) && \
    mkdir -p /usr/local/bin && \
    cp src/GucciCoind /usr/local/bin/GucciCoind && \
    cp src/walletd /usr/local/bin/walletd && \
    cp src/zedwallet /usr/local/bin/zedwallet && \
    cp src/miner /usr/local/bin/miner && \
    strip /usr/local/bin/GucciCoind && \
    strip /usr/local/bin/walletd && \
    strip /usr/local/bin/zedwallet && \
    strip /usr/local/bin/miner && \
    cd / && \
    rm -rf /src/guccicoin && \
    apt-get remove -y build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev librocksdb-dev && \
    apt-get autoremove -y && \
    apt-get install -y  \
      libboost-system1.58.0 \
      libboost-filesystem1.58.0 \
      libboost-thread1.58.0 \
      libboost-date-time1.58.0 \
      libboost-chrono1.58.0 \
      libboost-regex1.58.0 \
      libboost-serialization1.58.0 \
      libboost-program-options1.58.0 \
      libicu55

# setup the guccicoind service
RUN useradd -r -s /usr/sbin/nologin -m -d /var/lib/guccicoind guccicoind && \
    useradd -s /bin/bash -m -d /home/guccicoin guccicoin && \
    mkdir -p /etc/services.d/guccicoind/log && \
    mkdir -p /var/log/guccicoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/guccicoind/run && \
    echo "fdmove -c 2 1" >> /etc/services.d/guccicoind/run && \
    echo "cd /var/lib/guccicoind" >> /etc/services.d/guccicoind/run && \
    echo "export HOME /var/lib/guccicoind" >> /etc/services.d/guccicoind/run && \
    echo "s6-setuidgid guccicoind /usr/local/bin/GucciCoind" >> /etc/services.d/guccicoind/run && \
    chmod +x /etc/services.d/guccicoind/run && \
    chown nobody:nogroup /var/log/guccicoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/guccicoind/log/run && \
    echo "s6-setuidgid nobody" >> /etc/services.d/guccicoind/log/run && \
    echo "s6-log -bp -- n20 s1000000 /var/log/guccicoind" >> /etc/services.d/guccicoind/log/run && \
    chmod +x /etc/services.d/guccicoind/log/run && \
    echo "/var/lib/guccicoind true guccicoind 0644 0755" > /etc/fix-attrs.d/guccicoind-home && \
    echo "/home/guccicoin true guccicoin 0644 0755" > /etc/fix-attrs.d/guccicoin-home && \
    echo "/var/log/guccicoind true nobody 0644 0755" > /etc/fix-attrs.d/guccicoind-logs

VOLUME ["/var/lib/guccicoind", "/home/guccicoin","/var/log/guccicoind"]

ENTRYPOINT ["/init"]
CMD ["/usr/bin/execlineb", "-P", "-c", "emptyenv cd /home/guccicoin export HOME /home/guccicoin s6-setuidgid guccicoin /bin/bash"]
