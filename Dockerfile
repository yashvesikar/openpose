FROM ubuntu:20.04

ENV  DEBIAN_FRONTEND=noninteractive

WORKDIR /app

COPY . .

# prereqs
RUN apt-get update && apt-get install -y cmake git cmake-qt-gui protobuf-compiler libgoogle-glog-dev
## python
RUN apt-get install -y python3 python3-pip 
## opencv
RUN apt-get install -y libopencv-dev

RUN bash ./scripts/ubuntu/install_deps.sh

RUN apt-get install -y libboost-all-dev libhdf5-dev libatlas-base-dev
# project setup
RUN git submodule update --init --recursive --remote

# build the project
RUN mkdir build && \
    cd build && \
    cmake -D GPU_MODE=CPU_ONLY .. && \
    make -j`nproc`
