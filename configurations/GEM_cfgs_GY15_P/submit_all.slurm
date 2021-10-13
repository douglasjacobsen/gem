#!/bin/bash

PREP_JOB=`sbatch myprep.slurm`
PREP_JOB_ID=`echo $PREP_JOB | awk '{print $4}'`

BATCH_JOB=`sbatch -d afterok:${PREP_JOB_ID} mybatch.slurm`
BATCH_JOB_ID=`echo $BATCH_JOB | awk '{print $4}'`

echo "Prep job submitted as $PREP_JOB_ID"
echo "Batch job submitted as $BATCH_JOB_ID"
