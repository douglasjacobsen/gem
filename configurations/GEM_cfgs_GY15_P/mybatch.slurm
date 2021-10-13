#!/bin/bash
#SBATCH -N 35
#SBATCH -t 2000
#SBATCH -J GEM-Run

cd /home/dwjacobsen_google_com/Development/gem

export OMP_STACKSIZE=4G
export FOR_DISABLE_KMP_MALLOC=0

source /apps/spack/share/spack/setup-env.sh

module load gcc/10.3.0-gcc-4.8.5 git/2.31.1-gcc-10.3.0 intel/18.0.5-gcc-10.3.0 intel-mkl/2020.4.304-intel-18.0.5 intel-mpi/2018.4.274-intel-18.0.5 cmake/3.21.3-gcc-10.3.0 fftw/3.3.9-intel-18.0.5

#source common setup to find GEM binaries, scripts
. .common_setup intel
#cd to installed work directory to run
cd /home/dwjacobsen_google_com/Development/gem/work-CentOSLinux-7-x86_64-intel-18.0.5.274
runprep.sh -dircfg configurations/GEM_cfgs_GY15_P > listprep_gy 2>&1
runmod.sh -dircfg configurations/GEM_cfgs_GY15_P -ptopo 26x20x1 -inorder > list_gy
