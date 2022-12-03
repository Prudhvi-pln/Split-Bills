#!/bin/bash

[ -z "$1" ] && echo "Provide file name as an argument" && exit 1
[ ! -z "$2" ] && top=$2 || top=3

echo "Bill Amounts:"
cat "$1"
tot=$(echo $(cat "$1" | tr '\n' '+' | sed 's/+$//') | bc -l)
echo "Total: $tot"
echo
echo "Showing Top ${top} results:"
./src/divider.sh "$1" > .tmp.tmp
python3 ./src/divider.py "$1" >> .tmp.tmp
cat .tmp.tmp | awk -F'Diff: ' '{print $2}' | sort -nu | awk 'NF'| head -n${top} | while IFS= read -r df; do
    cat .tmp.tmp | grep -w "Diff: ${df}" | sort -u | head -n1
done
rm -f .tmp.tmp
