FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libpq-dev \
    curl \
    wget

RUN pip3 install \
    clickhouse-connect \
    psycopg2-binary

