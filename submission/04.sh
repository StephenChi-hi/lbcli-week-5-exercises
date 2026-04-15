# Create a CLTV script with a timestamp of 1495584032 and public key below:
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"
timestamp=1495584032

# pubkey hash from public key (SHA256 + RIPEMD160)
pubKeyHash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -hex | awk '{print $2}')

# Convert timestamp to little-endian hex (4 bytes)
timestamp_hex=$(printf '%08x' $timestamp | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/')

# OP_CHECKLOCKTIMEVERIFY=b1, OP_DROP=75, OP_DUP=76, OP_HASH160=a9, OP_EQUALVERIFY=88, OP_CHECKSIG=ac
# Script: <timestamp> OP_CHECKLOCKTIMEVERIFY OP_DROP OP_DUP OP_HASH160 <pubkeyhash> OP_EQUALVERIFY OP_CHECKSIG
echo "0420${timestamp_hex}b17576a914${pubKeyHash}88ac"
