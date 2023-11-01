import sys
import gzip
from rdkit import Chem

def converter(file_name,outname=None):
    f = gzip.open(file_name, "rb")
    sppl = Chem.ForwardSDMolSupplier(f)
    if outname != None:
        out_file = gzip.open(outname, "wb")

    for mol in sppl:
        if mol is not None:# some compounds cannot be loaded.
            smi = Chem.MolToSmiles(mol)
            name = mol.GetProp("_Name")
            if outname is None:
                print(f"{smi}\t{name}")
            else: 
                out_file.write(f"{smi}\t{name}\n".encode())

    if outname != None:
        out_file.close()

if __name__ == "__main__":

    # the input is a file w a list of sdf file base names
    with open(sys.argv[1]) as f:
        for line in f:
              line = line.rstrip()
              print("calling converter on basename {}".format(line))
              converter(line + '.sdf.tgz', outname = line + '.smi.gz')
            
