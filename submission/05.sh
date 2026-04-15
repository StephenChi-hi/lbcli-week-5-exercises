# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"
blocks=150

#  pubkey hash from public key (SHA256 + RIPEMD160)
pubKeyHash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -hex  | awk '{print $2}')

btcdeb/btcc $blocks OP_CHECKSEQUENCEVERIFY OP_DROP OP_DUP OP_HASH160 $pubKeyHash OP_EQUALVERIFY OP_CHECKSIG
