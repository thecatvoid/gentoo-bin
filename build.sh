#!/bin/dash

set -x e

chroot /gentoo/ /bin/sh -c 'set -x e

. /etc/profile

ln -sf /var/db/repos/gentoo/profiles/default/linux/amd64/17.1/systemd /etc/portage/make.profile

emerge dev-vcs/git

rm -rf /var/db/repos/* /var/cache

emerge-webrsync

mv $HOME/gentoo.conf /etc/portage/repos.conf

emerge --sync

(while true; do etc-update --automode -5; done &) > /dev/null 2>&1

cat /etc/portage/package-list | xargs emerge'
