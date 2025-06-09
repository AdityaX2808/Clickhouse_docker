# Clickhouse_docker
This repository contains the Clickhouse DB operations and datapipeline with postgresql using peerDB


# PostgreSQL to ClickHouse Data Pipeline using PeerDB and Docker Compose

## Overview

This project sets up a data integration pipeline using Docker Compose to orchestrate three services:

1. **PostgreSQL** – Serves as the source database.
2. **ClickHouse** – High-performance OLAP database, used as the target data sink.
3. **Python + Ubuntu** – A development container to execute ETL scripts and database queries.
4. **PeerDB** – An open-source real-time replication engine to sync data from PostgreSQL to ClickHouse.

The goal is to establish a reliable and efficient pipeline for real-time analytical processing.

---

## Project Structure

```
project-root/
├── docker-compose.yml
├── scripts/
│   └── init_queries.py
├── peerdb/                  # Cloned PeerDB repository
└── README.md
```

---

## Prerequisites

- Docker and Docker Compose
- Git
- WSL 2 (for Windows users)
- Internet access to clone PeerDB and pull images

---

## Setup Instructions

### Step 1: Clone Repository

```bash
git clone https://github.com/your-org/your-repo.git
cd your-repo
```

### Step 2: Start Docker Services

Use Docker Compose to bring up the containers:

```bash
docker-compose up -d
```

Services started:
- PostgreSQL available at `localhost:5432`
- ClickHouse available at `localhost:8123`
- Python/Ubuntu container with pre-installed drivers

### Step 3: Initialize Databases

Execute the database setup script inside the Python container:

```bash
docker exec -it <python-container-name> bash
python3 scripts/init_queries.py
```

This script:
- Creates sample databases and tables in PostgreSQL and ClickHouse
- Inserts initial data for verification

---

## Setting Up PeerDB

### Step 1: Clone PeerDB Repository

Clone PeerDB either inside the Python container or on your host system:

```bash
git clone https://github.com/peerdb-io/peerdb.git
cd peerdb
```

### Step 2: Start PeerDB

You can start PeerDB using their Docker Compose or other installation methods:

```bash
docker compose -f docker-compose.yml up -d
```

### Step 3: Create Replication Pipeline

Configure the pipeline via SQL commands or PeerDB API:

```sql
SELECT create_peer(...);
SELECT create_pipeline(...);
SELECT start_pipeline(...);
```

Ensure:
- PostgreSQL DSN is reachable
- ClickHouse DSN is correct
- Tables and schemas are aligned

---

## Monitoring and Logs

To verify pipeline status:

```bash
docker ps
docker logs <peerdb-container-name>
```

For database inspection:

```bash
psql -U postgres -h localhost -d <your_db>
clickhouse-client --host localhost
```

---

## Troubleshooting

| Issue                                 | Resolution                                             |
|--------------------------------------|--------------------------------------------------------|
| Docker container not connecting      | Use correct container names/aliases in connection URLs |
| Features auto-disable on reboot      | Ensure Virtual Machine Platform is enabled in BIOS     |
| PeerDB pipeline fails to start       | Check logs, confirm source/target compatibility        |

---

## References

- [PeerDB GitHub](https://github.com/peerdb-io/peerdb)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [ClickHouse Documentation](https://clickhouse.com/docs/en/)
- [Docker Compose](https://docs.docker.com/compose/)
