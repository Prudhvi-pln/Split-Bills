#!/bin/bash

#conf
cutoff=10000

infile=$1
cnt=$(cat $infile | wc -l)

#max=$((cnt/2))
min=$((cnt/2))
max=$((cnt-1))

calcSums() {
    cnt1=$1
    cnt2=$((cnt - cnt1))
    diff=0
    s1=$(echo $(cat $infile | sort -n | head -n${cnt1} | tr '\n' '+' | sed 's/+$//') | bc -l)
    s2=$(echo $(cat $infile | sort -nr | head -n${cnt2} | tr '\n' '+' | sed 's/+$//') | bc -l)
    diff=$((s1-s2))
    [ $diff -lt 0 ] && diff=$((0-diff))
    if [ $diff -le $cutoff ] && [ $diff -ge 0 ]; then
    	echo "List1: ($(echo $(cat $infile | sort -n | head -n${cnt1} | tr '\n' ' '))) with Sum: $s1, List2: ($(echo $(cat $infile | sort -nr | head -n${cnt2} | tr '\n' ' '))) with Sum: $s2, Diff: $diff"
    fi
}

for i in $(seq $max -1 $min); do
    calcSums $i
    #[ $diff -le $cutoff ] && [ $diff -gt 0 ] && break
done
