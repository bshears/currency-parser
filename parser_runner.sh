#!/bin/bash

START=$(date +%s.%N)
./currency_parser.rb GBP
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo -e "Ruby execution time :\t$DIFF\n"

START=$(date +%s.%N)
./currency_parser.py GBP
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo -e "Python execution time :\t$DIFF"
