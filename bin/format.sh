#!/usr/bin/dash

set -o errexit

#rustc - -Z unstable-options --pretty -o ./out
while read LINE; do
    echo ${LINE} >> out
done
echo ${LINE} >> out
printf '\377' # 255 in octal
exec cat out
#echo "hi"
