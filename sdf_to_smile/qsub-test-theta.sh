#!/bin/bash -x
#COBALT -A CSC249ADOA01
#COBALT -n 1 
#COBALT -t 00:10:00
#COBALT --jobname theta-test
#COBALT -q debug-flat-quad

export MPICH_CPUMASK_DISPLAY=1
export MPICH_RANK_REORDER_DISPLAY=1

env
aprun -n 2 -N 1 echo $ALPS_APP_PE
aprun -n 2 -N 1 hostname

