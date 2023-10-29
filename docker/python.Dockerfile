FROM python:3.12-slim

# pipx, virtualenv, poetry
ENV POETRY_NO_INTERACTION=1 \
    POETRY_HOME="/opt/poetry"
ENV PATH $POETRY_HOME/bin:/root/.local/bin:$PATH

RUN pip install pipx && \
    pipx install virtualenv && \
    pipx install poetry==1.6.1

# hyperfine & just
RUN apt-get update && \
    apt-get install -y  --no-install-recommends \
        curl \
        wget \
    ; \
    wget https://github.com/sharkdp/hyperfine/releases/download/v1.18.0/hyperfine_1.18.0_amd64.deb && \
    dpkg -i hyperfine_1.18.0_amd64.deb && \
    rm hyperfine_1.18.0_amd64.deb && \
    wget https://github.com/casey/just/releases/download/1.15.0/just-1.15.0-x86_64-unknown-linux-musl.tar.gz && \
    tar -xvf just-1.15.0-x86_64-unknown-linux-musl.tar.gz && \
    chmod +x just && \
    mv just /usr/local/bin/ && \
    rm just-1.15.0-x86_64-unknown-linux-musl.tar.gz
