#!/bin/bash
# Script para lectura de conexiones 
# Elaborado por Jorge Susunaga
# jsusunaga@novell.com

EXITCODE=""
WTHRESHOLD=$1	#Umbral Warning 4000
CTHRESHOLD=$2	#Umbral Critical 4700
#TYPE=$3
ESTAB=`netstat -nat | grep -ic ESTABLISHED` 
TIME=`netstat -nat | grep -ic TIME_WAIT` 
CLOSE=`netstat -nat | grep -ic CLOSE_WAIT` 

echo "OK, Connections |$ESTAB|$TIME|$CLOSE|"

function connection {
if [[ "${CONNECTYPE}" -lt "${WTHRESHOLD}"  ]]; then
	echo "OK, Connections | 'established'=${ESTAB}conns;${WTHRESHOLD};${CTHRESHOLD};0;100 'time_wait'=${TIME}conns;${WTHRESHOLD};${CTHRESHOLD};0;100 'close_wait'=${CLOSE}conns;${WTHRESHOLD};${CTHRESHOLD};0;100"
        EXITCODE="0"
        exit ${EXITCODE}
	elif [ ${CONNECTYPE} -ge ${WTHRESHOLD} ] && [ ${CONNECTYPE} -lt ${CTHRESHOLD} ]; then
	        echo "WARNING, Connections | 'established'=${ESTAB}conns;${WTHRESHOLD};${CTHRESHOLD};0;100 'time_wait'=${TIME}conns;${WTHRESHOLD};${CTHRESHOLD};0;100 'close_wait'=${CLOSE}conns;${WTHRESHOLD};${CTHRESHOLD};0;100"
		EXITCODE="1"
	        exit ${EXITCODE}
	else	
        echo "CRITICAL, Connections | 'established'=${ESTAB}conns;${WTHRESHOLD};${CTHRESHOLD};0;100 'time_wait'=${TIME}conns;${WTHRESHOLD};${CTHRESHOLD};0;100 'close_wait'=${CLOSE}conns;${WTHRESHOLD};${CTHRESHOLD};0;100"
        EXITCODE="2"
        exit ${EXITCODE}
fi
}

#connection
