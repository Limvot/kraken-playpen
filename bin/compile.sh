#!/usr/bin/dash

set -o errexit

#rustc - -C opt-level=$1 --emit=$2 -o ./out
while read LINE; do
    echo ${LINE} >> out.krak
done
echo ${LINE} >> out.krak
/build/kraken /kraken/krakenGrammer.kgm ./out.krak out > throwaway_stdout
printf '\377' # 255 in octal
echo "\n"
echo "==============="
echo "C.h Output:"
echo "===============\n"
cat out/out.h
echo "\n"
echo "==============="
echo "C.c Output:"
echo "===============\n"
cat out/out.c
