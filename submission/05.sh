# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"
blocks=150

#  pubkey hash from public key (SHA256 + RIPEMD160)
pubKeyHash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -hex  | awk '{print $2}')

# Convert blocks to little-endian hex (2 bytes for 150)
blocks_hex=$(printf '%04x' $blocks | sed 's/\(..\)\(..\)/\2\1/')

# OP_CHECKSEQUENCEVERIFY=b2, OP_DROP=75, OP_DUP=76, OP_HASH160=a9, OP_EQUALVERIFY=88, OP_CHECKSIG=ac
# Script: <blocks> OP_CHECKSEQUENCEVERIFY OP_DROP OP_DUP OP_HASH160 <pubkeyhash> OP_EQUALVERIFY OP_CHECKSIG
echo "02${blocks_hex}b27576a914${pubKeyHash}88ac"
