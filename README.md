# Simple Polaris Toy Example

## Quick Start

```
git clone https://github.com/brettin/polaris_examples
cd polaris_examples
qsub -v arg1=infiles submit.sh
```


## General Pattern
The general pattern involves 4 files. A PBS submit script (submit.sh), a run script run.sh, a deep learning python script (train.py), and a file (infiles) that contains the names of the dataframe files that contains the samples needed by the deep learning python script. More details follow.


## Specific Files

### submit.sh
The submit script will specify the PBS directives such as walltime, account to charge, jobname, number of compute nodes to use, etc. It is submitted using the qsub command. The -v option to the qsub command allows you to set environment variables that the submit.sh script can then see. I use an envirnment variable, arg1, to hold the name of a file that contains a list of input files.

```
qsub -v arg1=infiles ./submit.sh
```

This script, submit.sh, is executed on one compute host. When it executes, it launches 100 instances of run.sh, with each instance of run.sh executing on a different host. This happens with this line in the submit.sh script executes on a backend host.

```
mpiexec -ppn 1 -n 100 $PBS_O_WORKDIR/run_train.sh $arg1
```

If we look at this line further, it says run one hundred sepearate instances of train.sh, one process per node, and it passes each instance of train.sh the filename contained in the environment variable named arg1 (this was set with the -v option to qsub).

### run.sh
Nothing really special here. The filenames in infiles are read into a bash array. The MPI rank of the node on which the particular instance of run.sh is running is used as an index into that array to retreive a filename (dataframe) that gets passed to train.py.


### train.py
This is your deep learning code. 


### infiles
File of filenames. The named files should be somewhere that is visible to the compute nodes. I'm using ```/lus/eagle/projects/candle_aesp``` as projects are visible on all nodes.
