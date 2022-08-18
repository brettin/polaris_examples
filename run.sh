#!/bin/bash

# Reads the list of filenames into the array a
readarray -t a < $arg1

# Use the mpi rank as an index to get a specific filename
infile=${a[$PMI_RANK]}

# Train or something on infile
# CUDA_VISIBLE_DEVICES=0,1,2,3 python train.py --infile $infile
echo "running python train.py --infile $infile on $(hostname) with MPI Rank $PMI_RANK"

