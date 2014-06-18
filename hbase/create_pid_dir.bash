#!/usr/bin/env bash
mkdir -p /var/run/hbase
chown hbase:hadoop /var/run/hbase
chmod 0755 /var/run/hbase
