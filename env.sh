#!/bin/dash

# For detecting errors properly
set -ex

# Downloads Stage 3 Gentoo Targall and unpacks it (SYSTEMD)
mkdir -p /gentoo

curl -Lsq "https://github.com/thecatvoid/gentoo-wine-tar/releases/download/latest/gentoo.tar.gz" -o gentoo.tar.gz
tar xpf gentoo.tar.gz --xattrs-include='*.*' --numeric-owner -C /gentoo
rm -rf ./*.xz /gentoo/etc/portage

# Misc
mkdir -p /gentoo/etc/portage
mv package-list package.license \
    profile binrepos.conf make.conf \
    package.accept_keywords package.use repos.conf /gentoo/etc/portage/

mv /gentoo/etc/portage/repos.conf/gentoo.conf /gentoo/root/

# Chroot env
cp -L /etc/resolv.conf /gentoo/etc/resolv.conf
for i in dev sys run tmp proc; do mount -R /$i /gentoo/$i; done
