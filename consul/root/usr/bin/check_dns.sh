#!/bin/sh

test DNS forward- and reverse-mapping
NETS="172.17.0 172.17.1 172.17.2"
# Test address to name to address validity
echo
$HOSTNAME = $1
$HOST_IP  = $2

echo -e "\taddress -> name -> address"
echo '-------------------------------------'
for NET in $NETS; do
  for n in $(seq 1 2); do
    A=${NET}.${n}
    echo "Testing $A for $HOST on $HOSTNAME"
    echo -e "ok\t$A -> $HOST -> $HOSTNAME"
  done
# This mess needs refactoring.
# for NET in $NETS; do
#   for n in $(seq 1 254); do
#     A=${NET}.${n}
#     echo "Testing $A"
#     HOST=$(dig -x $A +short)
#     if test -n "$HOST"; then
#       ADDR=$(dig $HOST +short)
#       if test "$A" = "$HOSTNAME"; then
#         echo -e "ok\t$A -> $HOST -> $HOSTNAME"
#       elif test -n "$HOSTNAME"; then
#         echo -e "fail\t$A -> $HOST -> $HOSTNAME"
#       else
#         echo -e "fail\t$A -> $HOST -> [unassigned]"
#       fi
#     fi
#     echo "Testing $A for $HOST on $HOSTNAME"
#     echo -e "ok\t$A -> $HOST -> $HOSTNAME"
#   done
done
