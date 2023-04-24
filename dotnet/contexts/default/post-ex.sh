#! /bin/bash
if sh -c 'ls /etc/yum.repos.d/*.repo.bak 2>/dev/null'; then
    echo 'Restoring original repo files'
    rename .bak '' /etc/yum.repos.d/*.repo
fi

dnf clean all