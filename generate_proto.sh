#!/bin/bash
# Generate Go protobuf files

set -e

PROTO_DIR="./metroproto"
OUT_DIR="./proto"

if [ ! -f "$PROTO_DIR/listentogether.proto" ]; then
    echo "Missing proto file at $PROTO_DIR/listentogether.proto"
    echo "Attempting to clone the proto repository from EchoMusicApp/Echo-Music-Proto..."
    rm -rf "$PROTO_DIR"
    git clone https://github.com/EchoMusicApp/Echo-Music-Proto.git "$PROTO_DIR"
fi

# Create output directory if it doesn't exist
mkdir -p "$OUT_DIR"

# Generate Go code
protoc --go_out="$OUT_DIR" --go_opt=paths=source_relative \
    -I="$PROTO_DIR" \
    "$PROTO_DIR/listentogether.proto"

echo "Protobuf files generated successfully in $OUT_DIR"
