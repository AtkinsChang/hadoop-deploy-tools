#!/usr/bin/env bash
mkdir -p /var/run/hadoop/hdfs /var/run/hadoop/yarn /var/run/hadoop/mapred
chown hdfs:hadoop /var/run/hadoop/hdfs
chown yarn:hadoop /var/run/hadoop/yarn
chown mapred:hadoop /var/run/hadoop/mapred
chmod 0755 /var/run/hadoop/hdfs /var/run/hadoop/yarn /var/run/hadoop/mapred
