#!/usr/bin/env bash

# Master
create_spnego() {
	kadmin.local -q "add_principal -randkey HTTP/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k spnego.service.keytab HTTP/$1@PLSM.CS.NCCU.EDU.TW"
}

create_nn() {
	kadmin.local -q "add_principal -randkey nn/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "add_principal -randkey host/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k nn.service.keytab nn/$1@PLSM.CS.NCCU.EDU.TW host/$1@PLSM.CS.NCCU.EDU.TW"
}

create_rm() {
	kadmin.local -q "add_principal -randkey rm/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "add_principal -randkey wap/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k rm.service.keytab rm/$1@PLSM.CS.NCCU.EDU.TW host/$1@PLSM.CS.NCCU.EDU.TW wap/$1@PLSM.CS.NCCU.EDU.TW"
}

create_jhs() {
	kadmin.local -q "add_principal -randkey jhs/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k jhs.service.keytab jhs/$1@PLSM.CS.NCCU.EDU.TW host/$1@PLSM.CS.NCCU.EDU.TW"
}

# Slave
create_dn() {
	kadmin.local -q "add_principal -randkey dn/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "add_principal -randkey host/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k dn.service.keytab dn/$1@PLSM.CS.NCCU.EDU.TW host/$1@PLSM.CS.NCCU.EDU.TW"
}

create_nm() {
	kadmin.local -q "add_principal -randkey nm/$1@PLSM.CS.NCCU.EDU.TW"
	kadmin.local -q "xst -k nm.service.keytab nm/$1@PLSM.CS.NCCU.EDU.TW host/$1@PLSM.CS.NCCU.EDU.TW"
}

create_spnego ck.plsm.cs.nccu.edu.tw
create_nn ck.plsm.cs.nccu.edu.tw
create_rm ck.plsm.cs.nccu.edu.tw
create_jhs ck.plsm.cs.nccu.edu.tw

create_dn leo.plsm.cs.nccu.edu.tw
create_nm leo.plsm.cs.nccu.edu.tw
create_dn greg.plsm.cs.nccu.edu.tw
create_nm greg.plsm.cs.nccu.edu.tw
create_dn colin.plsm.cs.nccu.edu.tw
create_nm colin.plsm.cs.nccu.edu.tw
create_dn wenshan.plsm.cs.nccu.edu.tw
create_nm wenshan.plsm.cs.nccu.edu.tw
create_dn muzha.plsm.cs.nccu.edu.tw
create_nm muzha.plsm.cs.nccu.edu.tw
create_dn maokong.plsm.cs.nccu.edu.tw
create_nm maokong.plsm.cs.nccu.edu.tw
