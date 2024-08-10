#
# Domoticz Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM sdhibit/rpi-raspbian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

# Update & install packages
RUN apt-get update && \
    apt-get install -y wget git libssl-dev build-essential libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev curl libcurl4-openssl-dev libusb-dev zlib1g-dev

RUN cd /tmp && \
    wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz && \
    tar xf cmake-3.6.2.tar.gz && \
    cd cmake-3.6.2 && \
    ./bootstrap && make && make install

# Download & deploy domoticz
RUN git clone https://github.com/domoticz/domoticz.git domoticz
RUN cd domoticz && cmake -DCMAKE_BUILD_TYPE=Release .
RUN cd domoticz && make -j 3

EXPOSE 8080

CMD ["/domoticz/domoticz", "-www", "8080"]

