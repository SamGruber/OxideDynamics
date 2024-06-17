#!/bin/bash

#SBATCH -J chex
#SBATCH -A mat269
#SBATCH -p batch_cnms
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -c 1
##SBATCH --ntasks-per-node=36
##SBATCH --exclusive
#SBATCH --mem=0
#SBATCH -t 1-00:00:00
#SBATCH -o ./%j-output.log
#SBATCH -e ./%j-error.log

# loading modules and OF env variables
source $HOME/moose_modload

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo "script for running moose applications"
# multiple nodes
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# name of the solver
application=$HOME/projects/basepf/basepf-opt

$application -i s4_mobility_3D_meshed.i --split-mesh 128
srun $application -i s4_mobility_3D_meshed.i --use-split

