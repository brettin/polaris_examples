#!/bin/bash

# Reads the list of filenames into the array a
readarray -t a < $arg1

# Use the mpi rank as an index to get a specific filename
infile=${a[$PMI_RANK]}

# Do something on infile
#
echo "$(date +%Y:%m:%d:%T) running python ./sdf_smiles_convert_multi.py $infile on $(hostname) with MPI Rank $PMI_RANK"

python ./sdf_smiles_convert_multi.py $infile 2>/dev/null

# move files from /dev/shm back to $PBS_O_WORKDIR
ls -l /dev/shm
du -skh /dev/shm
df -kh /dev/shm

pushd /dev/shm/$infile
tar -cf $infile.tar *
popd
mv /dev/shm/*.tar .

echo "$(date +%Y:%m:%d:%T) done running python ./sdf_smiles_convert_multi.py $infile on $(hostname) with MPI Rank $PMI_RANK"
