FROM mattcl/aoc-python:3.12

# ruby and friends
# RUN ghcup install cabal

# lifted from the official ruby images
# skip installing gem documentation
RUN set -eux; \
	mkdir -p /usr/local/etc; \
	{ \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

ENV LANG C.UTF-8

# haskell
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
ENV BOOTSTRAP_HASKELL_GHC_VERSION=9.8.1
ENV BOOTSTRAP_HASKELL_CABAL_VERSION=3.10.2.0

# some of ruby's build scripts are written in ruby
#   we purge system ruby later to make sure our final image uses what we just built
RUN set -eux; \
	\
	apt-get install -y --no-install-recommends \
		autoconf \
		bison \
		ca-certificates \
		dpkg-dev \
		g++ \
		gcc \
		libbz2-dev \
		libgdbm-compat-dev \
		libgdbm-dev \
		libglib2.0-dev \
		libgmp-dev \
		libncurses-dev \
		libreadline-dev \
		libssl-dev \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		make \
		procps \
		xz-utils \
		zlib1g-dev \
        autoconf \
        bison \
        build-essential \
        bzip2 \
        clang \
        libffi-dev \
        libffi8 \
        libgmp-dev \
        libgmp10 \
        libncurses-dev \
        libncurses5 \
        libtinfo5 \
        llvm-14 \
        lua5.4 \
        nodejs \
        npm \
	; \
	rm -rf /var/lib/apt/lists/*; \
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# don't create ".bundle" in all our apps
ENV PATH $PATH:/usr/lib/llvm-11/bin
ENV PATH=${PATH}:/root/.local/bin
ENV PATH=${PATH}:/root/.ghcup/bin
