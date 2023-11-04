#!/bin/bash
#COBALT -t 10
#COBALT -n 2
#COBALT -A CSC249ADOA01
#COBALT -q debug-flat-quad 
#COBALT --attrs filesystems=eagle,grand,home


if [ -z "$arg1" ]; then
        echo "arg1 not set, it should be a filename"
	echo "qsub -v arg1=<filename>"
	echo "where <filename> contains input data filenames"
        exit
fi

# This should be the directory where qsub was executed
# echo "PBS_O_WORKDIR: $PBS_O_WORKDIR"
# cd $PBS_O_WORKDIR

# This file should contain the list of host names
echo "COBALT_NODEFILE: "$COBALT_NODEFILE

# This environment should get passed through mpiexec
module load conda
conda activate /lus/eagle/projects/candle_aesp/conda_envs/rdkit

# run one run.sh process per node on each of 10 nodes
# passing it the file of filenames.
# mpiexec -ppn 64 -np 128 ./run-theta.sh $arg1
aprun -n 128 -N 64 ./run-theta.sh $arg1
