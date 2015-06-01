#!/bin/sh

# test DNS forward- and reverse-mapping
NETS="172.17.0 172.17.1 172.17.2"

# Test address to name to address validity
echo
echo -e "\taddress -> name -> address"
echo '-------------------------------------'
for NET in $NETS; do
  for n in $(seq 1 254); do
    A=${NET}.${n}
    HOST=$(dig -x $A +short)
    if test -n "$HOST"; then
      ADDR=$(dig $HOST +short)
      if test "$A" = "$ADDR"; then
        echo -e "ok\t$A -> $HOST -> $ADDR"
      elif test -n "$ADDR"; then
        echo -e "fail\t$A -> $HOST -> $ADDR"
      else
        echo -e "fail\t$A -> $HOST -> [unassigned]"
      fi
    fi
  done
done
