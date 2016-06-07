#!/bin/bash
# -------------------------------------------------
# -------------------------------------------------
#SBATCH -o gpu.out
#SBATCH -J gpu
#SBATCH --get-user-env
#SBATCH --partition=nvd
#SBATCH --nodes=1
#SBATCH --time=02:00:00

# module load cuda/6.5
source /etc/profile.d/modules.sh

nvcc main.cu db.cu -o sim
nvprof ./sim
time ./sim
