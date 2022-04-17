#!/bin/bash
#alias lightning-cli="docker exec -it cln lightning-cli"
#docker exec -it cln lightning-cli getinfo
#working_path=/home/bitcoin/script-earning
BASEDIR=$(dirname $0)
working_path=${BASEDIR}
_now=$(date +"%d:%m:%Y")
JSON=`lightning-cli clboss-status | jq .offchain_earnings_tracker`
echo $JSON | jq -r 'map({in_earnings, in_expenditures}) | (first | keys_unsorted) as $keys | map([to_entries[] | .value]) as $rows | $keys,$rows[] | @csv' > $working_path/status.csv
awk -F"," '{x+=$1}END{print "Total earning: " x/1000}' $working_path/status.csv
awk -F"," '{x+=$2}END{print "Total spending: " x/1000}' $working_path/status.csv
EARN=`awk -F"," '{x+=$1}END{print x}' $working_path/status.csv `
SPEND=`awk -F"," '{x+=$2}END{print x}' $working_path/status.csv `
echo `awk -v e="$EARN" -v s="$SPEND" 'BEGIN {total=(e-s)/1000  ; print "Net profit: " total}'`
TOTAL=`awk -v e="$EARN" -v s="$SPEND" 'BEGIN {total=(e-s)/1000  ; print total}'`

if [ ! -f $working_path/result.csv ]; then
    echo "date,earn,spend,total" > $working_path/result.csv
fi

if [ "$1" = "csv" ]
then
echo `awk -v d="$_now" -v e="$EARN" -v s="$SPEND" -v t="$TOTAL" 'BEGIN {print d","e/1000","s/1000","t}'` >> $working_path/result.csv
fi
