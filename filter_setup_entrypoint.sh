#!/bin/bash -x
#
# A helper script for ENTRYPOINT.

set -e

cat >> /etc/fluent/fluent.conf <<_EOF_

<filter containerlog.**>
  type docker_metadata
</filter>

<match containerlog.**>
  type burrow
  key_name log
  action overlay
  format json
  add_prefix filtered
</match>

<system>
  log_level debug
</system>

_EOF_


if [ "$1" = 'fluentd' ]; then
  /etc/fluent/docker-loggly-entrypoint.sh $@
fi

exec "$@"
bash-4.2#