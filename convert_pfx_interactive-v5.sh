#!/bin/bash

# Function to prompt for input
prompt_for_input() {
    read -p "$1" input
    echo "$input"
}

# Prompt for the input PFX file
PFX_FILE=$(prompt_for_input "Enter the path to the .pfx file: ")

# Check if the file exists
if [ ! -f "$PFX_FILE" ]; then
    echo "File not found: $PFX_FILE"
    exit 1
fi

# Prompt for the output prefix
OUTPUT_PREFIX=$(prompt_for_input "Enter the output prefix for the generated files: ")

# Prompt for the PFX password (hidden input)
read -s -p "Enter the password for the .pfx file: " PFX_PASSWORD
echo # To move to the next line after password input

# Extract the private key without password
openssl pkcs12 -in "$PFX_FILE" -nocerts -out "${OUTPUT_PREFIX}.key" -nodes -passin pass:"$PFX_PASSWORD"

# Check if the private key extraction was successful
if [ $? -ne 0 ]; then
    echo "Failed to extract the private key."
    exit 1
fi

# Extract the certificate
openssl pkcs12 -in "$PFX_FILE" -clcerts -nokeys -out "${OUTPUT_PREFIX}.cert.pem" -passin pass:"$PFX_PASSWORD"

# Check if the certificate extraction was successful
if [ $? -ne 0 ]; then
    echo "Failed to extract the certificate."
    exit 1
fi

# Create a fullchain file (certificate + private key)
cat "${OUTPUT_PREFIX}.cert.pem" "${OUTPUT_PREFIX}.key" > "${OUTPUT_PREFIX}.fullchain.pem"

# Clean up the intermediate PEM file
echo "Conversion completed."
echo "Private Key: ${OUTPUT_PREFIX}.key"
echo "Certificate: ${OUTPUT_PREFIX}.cert.pem"
echo "Fullchain: ${OUTPUT_PREFIX}.fullchain.pem"
