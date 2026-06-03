---
title: EchoMusic
emoji: 🎧
colorFrom: purple
colorTo: indigo
sdk: docker
pinned: false
---

# Echo Music Server

A high-performance Go WebSocket server powering Metrolist's **Listen Together** feature — enabling real-time synchronized music playback across multiple clients. Built for speed and efficiency using Protocol Buffers (protobuf) and gzip compression.

## Features

- Real-time WebSocket communication between clients
- Protobuf serialization for compact, fast message encoding
- Gzip compression to minimize bandwidth usage
- Health check endpoint for monitoring and orchestration
- Configurable port via environment variable

## Prerequisites

Before running the server locally, ensure you have the following installed:

- [Go](https://go.dev/dl/) (1.21+)
- [Protocol Buffers compiler (`protoc`)](https://grpc.io/docs/protoc-installation/)
- [`protoc-gen-go`](https://pkg.go.dev/google.golang.org/protobuf/cmd/protoc-gen-go) plugin

## Quickstart

### Local

```bash
# Clone the repository
git clone https://github.com/EchoMusicApp/Echo-Music-Server
cd metroserver

# Generate protobuf files (required on first run)
chmod +x generate_proto.sh
./generate_proto.sh

# Download dependencies
go mod download

# Build the server
go build -o main .

# Run on the default port (8080)
./main

# Run on a custom port
PORT=9000 ./main
```

### Docker

```bash
# Clone the repository
git clone https://github.com/EchoMusicApp/Echo-Music-Server
cd metroserver

# Build the Docker image
docker build -t metroserver:latest .

# Run on the default port (8080)
docker run -d \
  -p 8080:8080 \
  -e PORT=8080 \
  --name metroserver \
  metroserver:latest

# Run on a custom port
docker run -d \
  -p 9000:9000 \
  -e PORT=9000 \
  --name metroserver \
  metroserver:latest
```

### Docker Compose

```yaml
services:
  metroserver:
    image: ghcr.io/MetrolistGroup/metroserver:latest
    ports:
      - "8080:8080"
    environment:
      - PORT=8080
    healthcheck:
      test:
        [
          "CMD",
          "wget",
          "--no-verbose",
          "--tries=1",
          "--spider",
          "http://localhost:8080/health",
        ]
      interval: 30s
      timeout: 3s
      retries: 3
      start_period: 5s
    restart: unless-stopped
```

## Configuration

| Environment Variable | Default | Description          |
|----------------------|---------|----------------------|
| `PORT`               | `8080`  | Port the server listens on |

## Health Check

The server exposes a health endpoint at:

```
GET http://localhost:<PORT>/health
```

This is used by Docker and orchestration platforms to verify the server is running correctly.

## License

See [LICENSE](./LICENSE) for details.

---

> This project is a fork of [MetrolistGroup/metroserver](https://github.com/MetrolistGroup/metroserver).