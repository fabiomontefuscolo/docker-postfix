#!/bin/bash
set -x

if [ -e "${SYSLOG_SOCK}" ];
then
    ln -sf "${SYSLOG_SOCK}" /dev/log
else
    ln -sf /run/rsyslog/dev/log /dev/log
fi

if [ "$(basename $1)" = "postfix" ];
then
    /usr/libexec/postfix/aliasesdb
fi

"$@"