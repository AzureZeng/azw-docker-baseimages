#! /bin/bash

if [ -n "$BUILDTIME_MIRROR" ]; then
    echo 'Overriding mirrorlist temporarily'
    sed -e 's|^mirrorlist=|#mirrorlist=|g' \
        -e "s|^#baseurl=http://dl.rockylinux.org/\$contentdir|baseurl=$BUILDTIME_MIRROR|g" \
        -i.bak \
        /etc/yum.repos.d/rocky*.repo
fi

dnf makecache
