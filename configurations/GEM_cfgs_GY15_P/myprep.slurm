#!/bin/bash
#SBATCH -N 1
#SBATCH -t 00:05:00
#SBATCH -J GEM-Prep


cd /home/dwjacobsen_google_com/Development/gem

export OMP_STACKSIZE=4G
export FOR_DISABLE_KMP_MALLOC=0

source /apps/spack/share/spack/setup-env.sh

module load gcc/10.3.0-gcc-4.8.5 git/2.31.1-gcc-10.3.0 intel/18.0.5-gcc-10.3.0 intel-mkl/2020.4.304-intel-18.0.5 intel-mpi/2018.4.274-intel-18.0.5 cmake/3.21.3-gcc-10.3.0

#source common setup to find GEM binaries,scripts
. .common_setup intel
cd /home/dwjacobsen_google_com/Development/gem/work-CentOSLinux-7-x86_64-intel-18.0.5.274
runprep.sh -dircfg configurations/GEM_cfgs_GY15_P > listprep_gy 2>&1
