FROM ubuntu:rolling

ENV CMAKE_BUILD_TYPE=MinSizeRel
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    cmake \
    nasm \
    && apt clean

WORKDIR /ports

COPY ports .

RUN cd ect \
    && cmake -B build src \
    && cd build \
    && make install/strip

FROM ubuntu:rolling

COPY --from=0 /usr/local /usr/local
