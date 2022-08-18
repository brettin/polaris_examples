#!/bin/bash

# Reads the list of filenames into the array a
readarray -t a < $arg1

# Use the mpi rank as an index to get a specific filename
infile=${a[$PMI_RANK]}

# Train or something on infile
# CUDA_VISIBLE_DEVICES=0,1,2,3 python simple_transformer.py --infile $infile
echo "running python simple_transformer.py --infile $infile on $(hostname) with MPI Rank $PMI_RANK"
