#PBS -l walltime=00:30:00
#PBS -l select=100:system=polaris
#PBS -l place=scatter
#PBS -l filesystems=home:eagle
#PBS -N test_100 
#PBS -A CSC249ADOA01
#PBS -q prod

if [ -z "$arg1" ]; then
        echo "arg1 not set, it should be a filename"
	echo "qsub -v arg1=<filename>"
	echo "where <filename> contains input data filenames"
        exit
fi

# This should be the directory where qsub was executed
# echo "PBS_O_WORKDIR: $PBS_O_WORKDIR"
cd $PBS_O_WORKDIR

# This file should contain the list of host names
# echo $PBS_NODEFILE
cat $PBS_NODEFILE

# This environment should get passed through mpiexec
module load conda/2022-07-19
conda activate base

# run one run.sh process per node on each of 100 nodes
# passing it the file of filenames.
mpiexec -ppn 1 -n 100 $PBS_O_WORKDIR/run.sh $arg1

