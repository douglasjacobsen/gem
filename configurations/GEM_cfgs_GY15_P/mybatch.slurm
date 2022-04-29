#!/bin/bash

NPEX=$1
NPEY=$2
WORK_DIR=$3

GEM_DIR=/home/dwjacobsen_google_com/Development/gem
cd ${GEM_DIR}

export OMP_STACKSIZE=4G
export FOR_DISABLE_KMP_MALLOC=0

source /apps/spack/share/spack/setup-env.sh

spack load intel@18.0.5
module load gcc/10.3.0-gcc-4.8.5 git/2.31.1-gcc-10.3.0 intel-mkl/2020.4.304-intel-18.0.5 intel-mpi/2018.4.274-intel-18.0.5 cmake/3.21.3-gcc-10.3.0 fftw/3.3.9-intel-18.0.5 fftw/3.3.9-intel-18.0.5

#source common setup to find GEM binaries, scripts
. .common_setup intel
#cd to installed work directory to run
cd ${WORK_DIR}
runprep.sh -dircfg configurations/GEM_cfgs_GY15_P > listprep_gy 2>&1
runmod.sh -dircfg configurations/GEM_cfgs_GY15_P -ptopo ${NPEX}x${NPEY}x1 -inorder > list_gy

cd ${GEM_DIR}
mv ${WORK_DIR} ${GEM_DIR}/scaling_runs
