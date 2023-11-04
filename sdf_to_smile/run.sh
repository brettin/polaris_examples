#!/bin/bash

# Reads the list of filenames into the array a
readarray -t a < $arg1

# Use the mpi rank as an index to get a specific filename
infile=${a[$PMI_RANK]}

# Do something on infile
#
echo "$(date +"%Y-%m-%d %T") running python ./sdf_smiles_convert_multi.py $infile on $(hostname) with MPI Rank $PMI_RANK"

# python writes to /dev/shm/$infile/
python ./sdf_smiles_convert_multi.py $infile 2>sdf_smiles_convert.errorlog

# move files from /dev/shm back to $PBS_O_WORKDIR
pushd /dev/shm/
tar -cf $infile.tar $infile
popd
mv /dev/shm/$infile.tar .
rm -rf /dev/shm/$infile

echo "$(date +"%Y-%m-%d %T") done running python ./sdf_smiles_convert_multi.py $infile on $(hostname) with MPI Rank $PMI_RANK"
