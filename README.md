<p align="center">
  <img src="assets/Echoicon.png" width="112" height="112" alt="Echo Music Logo" style="border-radius: 16px; object-fit: cover;" />
</p>

# Echo Music Server

Echo Music Server is a high-performance, concurrent WebSocket server written in Go. It powers the Listen Together feature, enabling real-time, synchronized music playback, queue sharing, and volume control across multiple clients.

## Attribution

This project is a fork of and extends the original WebSocket synchronization server built by MetrolistGroup:
* Original Repository: [MetrolistGroup/metroserver](https://github.com/MetrolistGroup/metroserver)

---

## Features

* Real-time WebSocket communication between clients
* Protocol Buffers (protobuf) serialization for compact, fast message encoding
* Gzip compression to minimize bandwidth usage
* Health check endpoint for automated status monitoring and orchestration
* Configurable port mapping via environment variables

---

## Hosting on Hugging Face Spaces

This server is optimized to run as a Docker Space on Hugging Face.

### Configuration
* **SDK**: Docker
* **Runtime Port**: 7860
* **Public WebSocket Endpoint**: `wss://<username>-<space-name>.hf.space/ws`
* **Public Health Check**: `https://<username>-<space-name>.hf.space/health`

### Automatic Protobuf Generation
The builder script is configured to automatically download the Protocol Buffer definitions from the public [Echo-Music-Proto](https://github.com/EchoMusicApp/Echo-Music-Proto) repository at build time. This ensures seamless deployments on environments where Git submodules are not cloned by default.

---

## Local Development

### Prerequisites

Ensure the following tools are installed on your system:
* Go (1.21 or higher)
* Protocol Buffers compiler (protoc)
* Go Protocol Buffers plugin (protoc-gen-go)

### Setup and Build

1. Clone the repository and navigate to the project directory:
   ```bash
   git clone https://github.com/EchoMusicApp/Echo-Music-Server
   cd Echo-Music-Server
   ```

2. Compile the Protocol Buffer files:
   ```bash
   chmod +x generate_proto.sh
   ./generate_proto.sh
   ```

3. Download the Go dependencies:
   ```bash
   go mod download
   ```

4. Build the server binary:
   ```bash
   go build -o main .
   ```

5. Start the server on the default port (8080):
   ```bash
   ./main
   ```

To run the server on a custom port, set the PORT environment variable:
```bash
PORT=9000 ./main
```

---

## Docker Support

### Build Image
```bash
docker build -t echo-music-server:latest .
```

### Run Container
```bash
docker run -d -p 8080:8080 -e PORT=8080 --name echo-music-server echo-music-server:latest
```

---

## Server Endpoints

### GET /
Displays server status and configuration instructions.

### GET /health
Used for checking the health status of the running server.
* Response: `{"status": "ok"}`

### GET /ws
Establish a WebSocket connection. Communications are serialized using Protocol Buffers.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.