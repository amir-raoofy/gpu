#!/bin/bash
# -------------------------------------------------
# -------------------------------------------------
#SBATCH -o %N-%j.out
#SBATCH -J gpu
#SBATCH --get-user-env
#SBATCH --partition=nvd
#SBATCH --nodes=1
#SBATCH --time=02:00:00

# module load cuda/6.5
source /etc/profile.d/modules.sh


make -s clean
make -s all -j16

time ./gpu 100 1000 0.1                      0 512
time ./cpu 100 1000 0.1 1 0.01 100000 100000 0

