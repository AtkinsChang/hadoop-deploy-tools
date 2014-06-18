#!/usr/bin/env bash

# Master
create_master() {
	kadmin.local -q "add_principal -randkey hmaster/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k hbase.service.keytab hmaster/$1@PLSM.CS.NCCU.EDU.TW"
}

# Slave
create_region() {
	kadmin.local -q "add_principal -randkey hregion/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k hbase.service.keytab hregion/$1@PLSM.CS.NCCU.EDU.TW"
}


create_master ck.plsm.cs.nccu.edu.tw

create_region leo.plsm.cs.nccu.edu.tw
create_region greg.plsm.cs.nccu.edu.tw
create_region colin.plsm.cs.nccu.edu.tw
create_region wenshan.plsm.cs.nccu.edu.tw
create_region muzha.plsm.cs.nccu.edu.tw
create_region maokong.plsm.cs.nccu.edu.tw

