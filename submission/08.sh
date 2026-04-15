# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

# pubkey hash from public key (SHA256 + RIPEMD160)
pubKeyHash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -hex | awk '{print $2}')

# 6 months = 180 days in 512-second units = 30375 = 0x76a7
# bit 22 set, value 0x400000: 0x40 | (0x76a7) as 3 bytes in LE = 0xa7 0x76 0x40
time_value_hex="0xa77640"

# then <time_value> OP_CHECKSEQUENCEVERIFY OP_DROP  OP_DUP  OP_HASH160 <pubkeyhash> OP_EQUALVERIFY OP_CHECKSIG
btcc $time_value_hex OP_CHECKSEQUENCEVERIFY OP_DROP OP_DUP OP_HASH160 $pubKeyHash OP_EQUALVERIFY OP_CHECKSIG

