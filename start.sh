#!/bin/bash


. "$HOME/.cargo/env"
source ~/.bashrc

cargo run --release --bin astrixd -- --utxoindex --rpclisten-json=default --rpclisten-borsh=default --perf-metrics &

# Capture the PID of the cargo process
ASTRIX_PID=$!

# Check if the PID was captured correctly
if [ -z "$ASTRIX_PID" ]; then
    echo "Error: Failed to get PID of cargo process."
    exit 1
fi

echo "Started astrixd with PID: $ASTRIX_PID"

# Wait until the process with the given PID exists
while ! kill -0 $ASTRIX_PID 2> /dev/null; do
    echo "Waiting for astrixd to start..."
    sleep 1
done

echo "astrixd is running, starting basic-http-server..."

# Start the second command
cd /git/astrix-node/wallet/wasm/web
basic-http-server /git/astrix-node/wallet/wasm/web -a 0.0.0.0:4000

