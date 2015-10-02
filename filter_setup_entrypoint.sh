#!/bin/bash -x
#
# A helper script for ENTRYPOINT.

set -e

cat >> /etc/fluent/fluent.conf <<_EOF_

<source>
  type forward
  port 24224
  bind 0.0.0.0
  log_level debug
</source>

<filter containerlog.**>
  type grep  
  exclude1 log ELB-HealthChecker
</filter>

<match containerlog.**>
  type burrow
  key_name log
  action overlay
  format json
  add_prefix filtered
</match>

_EOF_


if [ "$1" = 'fluentd' ]; then
  /etc/fluent/docker-loggly-entrypoint.sh $@
fi

exec "$@"
bash-4.2#