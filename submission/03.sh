# What is the address of the P2SH script wrapping the witness redeem script in this transaction
# transaction="020000000121654fa95d5a268abf96427e3292baed6c9f6d16ed9e80511070f954883864b100000000d90047304402201c97b48215f261055e41b765ab025e77a849b349698ed742b305f2c845c69b3f022013a5142ef61db1ff425fbdcdeb3ea370aaff5265eee0956cff9aa97ad9a357e301473044022000a402ec4549a65799688dd531d7b18b03c6379416cc8c29b92011987084e9f402205470e24781509c70e2410aaa6d827aa133d6df2c578e96a496b885584fb039200147522102da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d1912102bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa352aeffffffff0188130000000000001600142c48d3401f6abed74f52df3f795c644b4398844600000000"

transaction="020000000121654fa95d5a268abf96427e3292baed6c9f6d16ed9e80511070f954883864b100000000d90047304402201c97b48215f261055e41b765ab025e77a849b349698ed742b305f2c845c69b3f022013a5142ef61db1ff425fbdcdeb3ea370aaff5265eee0956cff9aa97ad9a357e301473044022000a402ec4549a65799688dd531d7b18b03c6379416cc8c29b92011987084e9f402205470e24781509c70e2410aaa6d827aa133d6df2c578e96a496b885584fb039200147522102da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d1912102bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa352aeffffffff0188130000000000001600142c48d3401f6abed74f52df3f795c644b4398844600000000"

# decode transaction
decoded_tx=$(bitcoin-cli -regtest decoderawtransaction "$transaction")

# witness redeem script using positional indexing (last element of scriptSig asm)
witness_redeem_script=$(echo "$decoded_tx" | jq -r '.vin[0].scriptSig.asm | split(" ") | .[-1]')

#  witness redeem script hasheds(SHA256 + RIPEMD160) to get P2SH script hash
script_hash=$(echo -n "$witness_redeem_script" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -hex | awk '{print $2}')

#  P2SH scriptPubKey (OP_HASH160 + hash + OP_EQUAL)
p2sh_script="a914${script_hash}87"

# decode the P2SH script and  address
address=$(bitcoin-cli -regtest decodescript "$p2sh_script" | jq -r '.address')

echo "$address"
