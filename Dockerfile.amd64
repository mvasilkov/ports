FROM ubuntu:rolling

ENV CMAKE_BUILD_TYPE=MinSizeRel
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

RUN apt update && apt install -y --no-install-recommends \
	autoconf \
	automake \
	build-essential \
	cmake \
	git \
	libjpeg-turbo8-dev \
	libpng-dev \
	libz-dev \
	nasm \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /ports

COPY . .

RUN cd ports/ect \
	&& cmake -B build src \
	&& cd build \
	&& make install/strip

RUN cd ports/advancecomp \
	&& sed -i 's/if \[ -d .git \]; then/if \[ -e .git \]; then/' autover.sh \
	&& autoreconf -i \
	&& ./configure \
	&& make all check-local install-strip

RUN cd ports/jpeg2png \
	&& sed -i 's#/usr/bin/jpeg2png#/usr/local/bin/jpeg2png#g' Makefile \
	&& make install

FROM ubuntu:rolling

RUN apt update && apt install -y --no-install-recommends \
	libgomp1 \
	libjpeg-turbo8 \
	libpng16-16 \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=0 /usr/local /usr/local
