#!/bin/bash

PPN=30
PART="c2"

#PPN=56
#PART="c2d"

NPEX_VALS=`cat uniq_npex.txt`
NPEY_VALS=`cat uniq_npey.txt`

GEM_DIR=/home/dwjacobsen_google_com/Development/gem
SCALING_DIR=/home/dwjacobsen_google_com/Development/gem/scaling_runs
BASE_DIR=/home/dwjacobsen_google_com/Development/gem/work-CentOSLinux-7-x86_64-intel-18.0.5.274

for NPEX in ${NPEX_VALS}
do
	for NPEY in ${NPEY_VALS}
	do
		MPI=$((2*$NPEX*$NPEY))
		NODES=$(($MPI/$PPN))
		if [ $(($MPI%$PPN)) -gt 0 ]; then
			NODES=$(($NODES+1))
		fi
		RUN_DIR="${GEM_DIR}/${NPEX}x${NPEY}_${MPI}_${NODES}_run"

		if [ -d ${RUN_DIR} ]; then
			rm -rf ${RUN_DIR}
		fi
		cp -r $BASE_DIR $RUN_DIR
		cd $RUN_DIR
		cp ${GEM_DIR}/configurations/GEM_cfgs_GY15_P/*.slurm ${RUN_DIR}
		SUB_OUT=`sbatch -N $NODES --ntasks-per-node $PPN -p $PART scaling_batch.slurm $NPEX $NPEY $RUN_DIR`
		JOB_ID=`echo ${SUB_OUT} | awk '{print $4}'`
	done
done
