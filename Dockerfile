FROM ubuntu:rolling

ENV CMAKE_BUILD_TYPE=MinSizeRel
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    nasm \
    && apt clean


FROM ubuntu:rolling
