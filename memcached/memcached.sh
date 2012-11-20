#!/bin/sh
### Memcached module Sshell Script			###
### Create	2012/04/20 M.Oobayashi			###
### Last Update 2012/04/20 M.Oobayashi			###

#-----------------------------------------------------------
# Parameter
#-----------------------------------------------------------
MEMPORT=11211
MEMHOST=HOGEHOGE
CMD=$1

#-----------------------------------------------------------
# Function
#-----------------------------------------------------------

mem_save(){
	expect -c "
	set timeout 1
	spawn telnet ${MEMHOST} ${MEMPORT}
	expect \"Escape character is '^]'.\"
	send \"set ${1} 0 ${3} ${4} \n\"
	send \"${2}\n\"
	expect \"STORED\"
	send \"quit\n\"
	" > /dev/null 2>&1
}

mem_get(){
	expect -c "
	set timeout 1
	spawn telnet ${MEMHOST} ${MEMPORT}
	expect \"Escape character is '^]'.\"
	send \"get ${1} 0 ${3} ${4} \n\"
	expect \"END\"
	send \"quit\n\"
	" > /tmp/.mem_get_dump

	sed -i '1,6d' /tmp/.mem_get_dump
	sed -i '/^END/d' /tmp/.mem_get_dump
	sed -i 's/\r//g' /tmp/.mem_get_dump
	cat /tmp/.mem_get_dump
	\rm /tmp/.mem_get_dump
}

mem_del(){
	expect -c "
	set timeout 1
	spawn telnet ${MEMHOST} ${MEMPORT}
	expect \"Escape character is '^]'.\"
	send \"delete $1 \n\"
	expect \"D\"
	send \"quit\n\"
	" > /dev/null 2>&1
}

#-----------------------------------------------------------
# Script
#-----------------------------------------------------------

case ${CMD} in
	save)
		MKEY=$2
		MVAL=$3
		MTIM=$4

		if [ "${MKEY}" != "" -a "${MVAL}" != "" -a "${MTIM}" != "" ]; then
			MBYT=`echo ${MVAL} | wc -L`

			mem_save "${MKEY}" "${MVAL}" "${MTIM}" "${MBYT}"

		else
			echo "Parameter error."
		fi
		;;
	get)
		MKEY=$2
		mem_get "${MKEY}"
		;;
	del)
		MKEY=$2
		mem_del "${MKEY}"
		;;
	*)
		echo "Usage : ${0} save <key> <val> <time(sec)>"
		echo "        ${0} get  <key>"
		echo "        ${0} del  <key>"
	exit;;
esac
