FROM ubuntu:rolling

ENV CMAKE_BUILD_TYPE=MinSizeRel
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
	autoconf \
	automake \
	build-essential \
	cmake \
	git \
	libz-dev \
	nasm \
	&& apt clean

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

FROM ubuntu:rolling

COPY --from=0 /usr/local /usr/local
