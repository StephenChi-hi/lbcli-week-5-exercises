# Find the P2SH address for the following redeem script:
# redeemScript="522102da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d1912102bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa352ae"

redeemScript="522102da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d1912102bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa352ae"

#  redeemScript hashs (SHA256 + RIPEMD160) to get script hash
script_hash=$(echo -n "$redeemScript" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -hex | awk '{print $2}')

#  P2SH scriptPubKey (OP_HASH160 + hash + OP_EQUAL)
p2sh_script="a914${script_hash}87"

# decode the P2SH script for  address 
address=$(bitcoin-cli -regtest decodescript "$p2sh_script" | jq -r '.address')

echo "$address"
