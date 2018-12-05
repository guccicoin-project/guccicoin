# daemon runs in the background
# run something like tail /var/log/GucciCoind/current to see the status
# be sure to run with volumes, ie:
# docker run -v $(pwd)/GucciCoind:/var/lib/GucciCoind -v $(pwd)/wallet:/home/guccicoin --rm -ti guccicoin:0.2.2
FROM ubuntu:18.04

ARG GUCCICOIN_BRANCH=master
ENV GUCCICOIN_BRANCH=${GUCCICOIN_BRANCH}

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get install -y \
      build-essential \
      python-dev \
      python-pip \
      gcc \
      g++ \
      git \
      libboost-all-dev && \
    python -m pip install cmake && \
    git clone https://github.com/guccicoin-project/guccicoin.git /src/guccicoin && \
    cd /src/guccicoin && \
    git checkout $GUCCICOIN_BRANCH && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) && \
    mkdir -p /usr/local/bin
WORKDIR /src/guccicoin
RUN ls -la build/src
RUN cp build/src/GucciCoind /usr/local/bin/GucciCoind && \
    cp build/src/gucci-service /usr/local/bin/gucci-service && \
    cp build/src/zedwallet /usr/local/bin/zedwallet && \
    cp build/src/miner /usr/local/bin/miner && \
    strip /usr/local/bin/GucciCoind && \
    strip /usr/local/bin/gucci-service && \
    strip /usr/local/bin/zedwallet && \
    strip /usr/local/bin/miner && \
    cd / && \
    rm -rf /src/guccicoin && \
    apt-get remove -y build-essential python-dev gcc g++ git cmake libboost-all-dev librocksdb-dev && \
    apt-get autoremove -y && \
    add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt-get update && \
    apt-get install -y  \
      libboost-all-dev \
      libicu55

# setup the GucciCoind service
RUN useradd -r -s /usr/sbin/nologin -m -d /var/lib/GucciCoind GucciCoind && \
    useradd -s /bin/bash -m -d /home/guccicoin guccicoin && \
    mkdir -p /etc/services.d/GucciCoind/log && \
    mkdir -p /var/log/GucciCoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/GucciCoind/run && \
    echo "fdmove -c 2 1" >> /etc/services.d/GucciCoind/run && \
    echo "cd /var/lib/GucciCoind" >> /etc/services.d/GucciCoind/run && \
    echo "export HOME /var/lib/GucciCoind" >> /etc/services.d/GucciCoind/run && \
    echo "s6-setuidgid GucciCoind /usr/local/bin/GucciCoind" >> /etc/services.d/GucciCoind/run && \
    chmod +x /etc/services.d/GucciCoind/run && \
    chown nobody:nogroup /var/log/GucciCoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/GucciCoind/log/run && \
    echo "s6-setuidgid nobody" >> /etc/services.d/GucciCoind/log/run && \
    echo "s6-log -bp -- n20 s1000000 /var/log/GucciCoind" >> /etc/services.d/GucciCoind/log/run && \
    chmod +x /etc/services.d/GucciCoind/log/run
#RUN echo "/var/lib/GucciCoind true GucciCoind 0644 0755" > /etc/fix-attrs.d/GucciCoind-home && \
#    echo "/home/guccicoin true guccicoin 0644 0755" > /etc/fix-attrs.d/guccicoin-home && \
#    echo "/var/log/GucciCoind true nobody 0644 0755" > /etc/fix-attrs.d/GucciCoind-logs

VOLUME ["/var/lib/GucciCoind", "/home/guccicoin","/var/log/GucciCoind"]

CMD ["GucciCoind"]
