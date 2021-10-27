#!/bin/bash

NPEX_VALS=`cat uniq_npex.txt`
NPEY_VALS=`cat uniq_npey.txt`

GEM_DIR=/home/dwjacobsen_google_com/Development/gem
SCALING_DIR=/home/dwjacobsen_google_com/Development/gem/scaling_runs
BASE_DIR=/home/dwjacobsen_google_com/Development/gem/work-CentOSLinux-7-x86_64-intel-18.0.5.274

cd $SCALING_DIR
PERF_FILE=${SCALING_DIR}/perf_summary.csv
rm -f perf_summary.csv
touch perf_summary.csv
echo "NPEX,NPEY,MPI Ranks,Nodes,Min Time (s),Max Time (s)" >> ${PERF_FILE}

for NPEX in ${NPEX_VALS}
do
	for NPEY in ${NPEY_VALS}
	do
		MPI=$((2*$NPEX*$NPEY))
		NODES=$(($MPI/30))
		RUN_DIR="${SCALING_DIR}/${NPEX}x${NPEY}_${MPI}_${NODES}_run"

		if [ -d ${RUN_DIR} ]; then
			OUT_FILE="${RUN_DIR}/list_gy"
			MIN_SEC=`grep --text "CP SECS =" ${OUT_FILE} | head -n 1 | awk '{print $6}'`
			MAX_SEC=`grep --text "CP SECS =" ${OUT_FILE} | tail -n 1 | awk '{print $6}'`
			echo "${NPEX},${NPEY},${MPI},${NODES},${MIN_SEC},${MAX_SEC}" >> ${PERF_FILE}
		fi
	done
done
