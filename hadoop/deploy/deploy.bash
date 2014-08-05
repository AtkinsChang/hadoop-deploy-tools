#!/usr/bin/env bash
# This script deploy hadoop to standard linux structure
# Configuration files at /etc/hadoop
# Installation dir at /usr/lib/hadoop
# Data dir at /var/lib/hadoop/[hdfs, yarn, mapred]
# Log dir at /var/log/hadoop/[hdfs, yarn,madred]

##################################################################################
# Settings
##################################################################################
# Hadoop layout scrpit path
HADOOP_LAYOUT_PATH=.

# ROOT is hadoop root after download/compiled
ROOT=.

# User for each daemons
YARN=yarn
HDFS=hdfs
MAPRED=mapred

# Group
HADOOP_GROUP=hadoop

# Installation dir
HADOOP_HOME=/usr/lib/hadoop
HADOOP_CONFIG_DIR=/etc/hadoop

# Container executer
CONTAINER_EXECUTOR_PATH=${HADOOP_HOME}/bin/container-executor
CONTAINER_EXECUTOR_CFG_PATH=${HADOOP_CONFIG_DIR}/container-executor.cfg

# Log dir
LOG_HOME=/var/log/hadoop
LOG_PREM=0775

# Data dir
DATA_HOME=/var/lib/hadoop
DATA_PREM=0750
##################################################################################
# Setting end
##################################################################################

create_log_dir() {
	mkdir -p $LOG_HOME/$1
	chown $1:$HADOOP_GROUP $LOG_HOME/$1
	chmod $LOG_PREM $LOG_HOME/$1
}

create_data_dir() {
	mkdir -p $DATA_HOME/$1
	chown $1:$HADOOP_GROUP $DATA_HOME/$1
	chmod $DATA_PREM $DATA_HOME/$1
}

deploy() {
	mkdir -p $HADOOP_HOME

	# bin
	rm -rf $ROOT/bin/*.cmd
	cp -R $ROOT/bin $HADOOP_HOME/

	# etc
	rm -rf $ROOT/etc/hadoop/*.cmd
	rm -rf $HADOOP_CONFIG_DIR/template
	mkdir -p $HADOOP_CONFIG_DIR/template
	cp $ROOT/etc/hadoop/* $HADOOP_CONFIG_DIR/template

	# include
	cp -Rf $ROOT/include $HADOOP_HOME/

	# lib
	cp -Rf $ROOT/lib $HADOOP_HOME/

	# libexec
	rm -rf $ROOT/libexec/*.cmd
	cp -Rf $ROOT/libexec $HADOOP_HOME/
	cp -Rf $HADOOP_LAYOUT_PATH/hadoop-layout.sh $HADOOP_HOME/libexec

	# sbin
	rm -rf $ROOT/sbin/*.cmd
	cp -Rf $ROOT/sbin $HADOOP_HOME/

	# share
	cp -Rf $ROOT/share $HADOOP_HOME/
}


deploy

# Handle hadoop container executor
chown root:$HADOOP_GROUP ${CONTAINER_EXECUTOR_PATH}
chmod 6050 ${CONTAINER_EXECUTOR_PATH}
chown root:root ${CONTAINER_EXECUTOR_CFG_PATH}
chmod 0600 ${CONTAINER_EXECUTOR_CFG_PATH}

# Data dir
mkdir -p $DATA_HOME
chown root:$HADOOP_GROUP $DATA_HOME
chmod g+w $DATA_HOME
create_data_dir $HDFS
create_data_dir $YARN
chmod 0755 $DATA_HOME/yarn
create_data_dir $MAPRED

# Log dir
mkdir -p $LOG_HOME
chown root:$HADOOP_GROUP $LOG_HOME
chmod g+w $LOG_HOME
create_log_dir $HDFS
create_log_dir $YARN
mkdir -p $LOG_HOME/$YARN/userlogs
chown $YARN:hadoop $LOG_HOME/$YARN/userlogs
chmod 0755 $LOG_HOME/$YARN/userlogs
create_log_dir mapred

# Tmp dir
mkdir -p $DATA_HOME/tmp
chown root:$HADOOP_GROUP $DATA_HOME/tmp
chmod 1777 $DATA_HOME/tmp

echo 'Finished'
