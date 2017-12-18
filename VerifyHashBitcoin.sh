# Studying Bitcoin
# Ver 0.1 -- Gualotto Piergiovanni
#
#
#
# Verify Hash 
# get rawblock 'https://blockchain.info/rawblock/000000000000000000586048c9428a48697c64ccbb84c243321e3f8ce4d0f84a'
#
# {
#    "hash":"000000000000000000586048c9428a48697c64ccbb84c243321e3f8ce4d0f84a",
#    "ver":536870912,
#    "prev_block":"00000000000000000068d8c7b776a9079904dfe4fa7b093c40cbb64aa77af2f6",
#    "mrkl_root":"8dbf040eea2f160472b57c2b925738b8c3e3252f5099031643aa8f9a6980d2a7",
#    "time":1513527688,
#    "bits":402698477,
#    "fee":428612473,
#    "nonce":1299284,
#    "n_tx":2789,
#    "size":1060664,
#    "block_index":1651012,
#    "main_chain":true,
#    "height":499808,
#    "received_time":1513527688,
#    "relayed_by":"0.0.0.0",
# .....    
# ....
#
#
#!/bin/bash 

#set -x 

HS='000000000000000000586048c9428a48697c64ccbb84c243321e3f8ce4d0f84a'

ver=$(printf "%08x\n" 536870912) # - Version
time=$(echo "obase=16;$(date "+%s" -d '2017-12-17 16:21:28 +0')" |bc) # - Time -> "time":1513527688
bits=$(printf "%08x\n" 402698477) # Target 
hpre=00000000000000000068d8c7b776a9079904dfe4fa7b093c40cbb64aa77af2f6 # - Previous Block
meroot=8dbf040eea2f160472b57c2b925738b8c3e3252f5099031643aa8f9a6980d2a7 # - Merkle Root 
nonce=$(printf "%08x\n" 1299284) # - Nonce


# function  hex to little endian format 

lend () { 

in=$1
c=${#in}

while [ $c -gt 0 ]
 do
  c=$(($c - 2))
  ex="$ex"${in:$c:2}
done

 echo $ex
}

#

# Convert Hex to little endian format
v=$(lend $ver)
p=$(lend $hpre)
m=$(lend $meroot)
t=$(lend $time)
b=$(lend $bits)
n=$(lend $nonce)

echo
echo verifying hash $HS
echo
echo "Block Header"
echo
echo $v
echo $p
echo $m
echo $t
echo $b
echo $n
echo
#
echo
echo  $v$p$m$t$b$n | awk '{print tolower($0)}' | xxd -r -p | sha256sum | sed 's/\s\-//g' | xxd -r -p | sha256sum
echo 
lend $(echo $v$p$m$t$b$n | awk '{print tolower($0)}' | xxd -r -p | sha256sum | sed 's/\s\-//g' | xxd -r -p | sha256sum)
echo
echo End




