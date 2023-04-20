#!/bin/bash

# Replace the following variables with the actual values
SERVER_PUBLIC_KEY="SERVER_PUBLIC_KEY_HERE"
CLIENT_IP="CLIENT_IP_HERE"
ENDPOINT_ADDRESS="ENDPOINT_ADDRESS_HERE"
ENDPOINT_PORT="ENDPOINT_PORT_HERE"
ZIP_FILE_PATH="client-config.zip"

# Generate a new private key for the client
CLIENT_PRIVATE_KEY="$(wg genkey)"

# Derive the public key from the private key
CLIENT_PUBLIC_KEY="$(echo "$CLIENT_PRIVATE_KEY" | wg pubkey)"

# Define the WireGuard configuration file path
WG_CONFIG_PATH="./client.conf"

# Add the new client configuration to the configuration file
echo "[Interface]
PrivateKey = $CLIENT_PRIVATE_KEY
Address = $CLIENT_IP/32
DNS = 1.1.1.1

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $ENDPOINT_ADDRESS:$ENDPOINT_PORT
AllowedIPs = 0.0.0.0/0
" >> "$WG_CONFIG_PATH"

# Create a ZIP archive containing the configuration file
zip "$ZIP_FILE_PATH" "$WG_CONFIG_PATH"

# Output the path to the ZIP file
echo "Client configuration file created: $ZIP_FILE_PATH"