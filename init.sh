#!/bin/bash

set -o errexit -o nounset -o pipefail

cd "${BASH_SOURCE%/*}"

umask 022

rm -rf root-master.new
mkdir root-master.new

pacstrap -c -d root-master.new \
    bash \
    coreutils \
    grep \
    dash \
    filesystem \
    glibc \
    pacman \
    procps-ng \
    shadow \
    util-linux \
    gcc \

mkdir root-master.new/dev/shm
mknod -m 666 root-master.new/dev/null c 1 3
mknod -m 644 root-master.new/dev/urandom c 1 9
arch-chroot root-master.new useradd -m rust
install -m755 bin/* root-master.new/usr/local/bin

#rm -rf root-0.12.0.new
#cp -a root-master.new root-0.12.0.new
#pacman -r root-master.new -S rust-git --noconfirm
#pacman -r root-0.12.0.new -S rust --noconfirm

#curl -O https://static.rust-lang.org/rustup.sh
#sh rustup.sh --prefix=root-master.new
#rm rustup.sh

git clone https://github.com/Limvot/kraken.git root-master.new/kraken
#mkdir root-master.new/build
#cd root-master.new/build
cd root-master.new/kraken
./captain.sh
#cmake ../kraken
#make
#./kraken ../kraken/krakenGrammer.kgm ../kraken/tests/test_string.krak throwaway_build
cd ../..

[[ -d root-master ]] && mv root-master root-master.old
mv root-master.new root-master
[[ -d root-master.old ]] && rm -rf root-master.old

#[[ -d root-0.12.0 ]] && mv root-0.12.0 root-0.12.0.old
#mv root-0.12.0.new root-0.12.0
#[[ -d root-0.12.0.old ]] && rm -rf root-0.12.0.old
