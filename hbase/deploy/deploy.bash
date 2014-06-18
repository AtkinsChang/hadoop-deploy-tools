#!/usr/bin/env bash
# This script deploy hadoop to standard linux structure
# Configuration files at /etc/hbase
# Installation dir at /usr/lib/hbase
# Data dir at /var/lib/hbase
# Log dir at /var/log/hbase

##################################################################################
# Settings
##################################################################################
# ROOT is hbase root after download/compiled
ROOT=.

# User for each daemons
HBASE=hbase

# Group
HBASE_GROUP=hadoop

# Installation dir
HBASE_HOME=/usr/lib/hbase
HBASE_CONFIG_DIR=/etc/hbase

# Log dir
LOG_HOME=/var/log/hbase
LOG_PREM=0775

# Data dir
DATA_HOME=/var/lib/hbase
DATA_PREM=0750
##################################################################################
# Setting end
##################################################################################

create_log_dir() {
	mkdir -p $LOG_HOME/$1
	chown $1:$HBASE_GROUP $LOG_HOME/$1
	chmod $LOG_PREM $LOG_HOME/$1
}

create_data_dir() {
	mkdir -p $DATA_HOME/$1
	chown $1:$HBASE_GROUP $DATA_HOME/$1
	chmod $DATA_PREM $DATA_HOME/$1
}

deploy() {
	mkdir -p $HBASE_HOME

	# bin
	rm -rf $ROOT/bin/*.cmd
	cp -R $ROOT/bin $BASE_HOME/

	# conf
	rm -rf $ROOT/conf/*.cmd
	rm -rf $HBASE_CONFIG_DIR/template
	mkdir -p $HBASE_CONFIG_DIR/template
	cp -R $ROOT/conf/* $HBASE_CONFIG_DIR/template

	# hbase-webapps
	rm -rf $HBASE_HOME/hbase-webapps
	cp -Rf $ROOT/hbase-webapps $HBASE_HOME/

	# lib
	rm -rf $HBASE_HOME/lib
	cp -Rf $ROOT/lib $HBASE_HOME/

}


deploy

# Data dir
mkdir -p $DATA_HOME
chown root:$HBASE_GROUP $DATA_HOME
chmod g+w $DATA_HOME
create_data_dir $HBASE

# Log dir
mkdir -p $LOG_HOME
chown root:$HBASE_GROUP $LOG_HOME
chmod g+w $LOG_HOME
create_log_dir $HBASE

echo 'Finished'
