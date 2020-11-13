#!/bin/bash

for i in $(seq 36 85); do
   file=MDR1_rockstar_${i}_bnl.dat
   cut -b -52 old/$file > $file
done