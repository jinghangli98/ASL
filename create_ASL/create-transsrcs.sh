#!/bin/bash

# Generate multiple transmission line files from a single file
#
# Usage:
# ./create-transsrcs.sh <path_to_transsrc_file>

input=$1

filename=$(basename "$input")
directory=$(dirname "$input")
channels=$(wc -l < "$input")

name=${filename%%.*}
extension=${filename#*.}

for i in $(seq 1 $channels)
do
	sed "s/[0-9]\+$/0/g; ${i}s/[0-9]\+$/1/" $input > $directory/$name$i.$extension
done
