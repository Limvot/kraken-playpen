#!/usr/bin/dash

set -o errexit

#rustc - -C opt-level=$1 -o ./out
while read LINE; do
    echo ${LINE} >> out.krak
done
echo ${LINE} >> out.krak
#/build/kraken /kraken/krakenGrammer.kgm ./out.krak out > throwaway_stdout
cat out.krak
/kraken/kraken ./out.krak

#/kraken/kraken ./out.krak > /dev/null
#cd out
#sh out.sh
echo "\n"
echo "==============="
echo "Program Output:"
echo "===============\n"
printf '\377' # 255 in octal
exec ./out
