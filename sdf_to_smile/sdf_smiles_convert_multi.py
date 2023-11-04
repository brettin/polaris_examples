import sys
import gzip
import os
from rdkit import Chem


def converter(file_name,outname=None):
    f = gzip.open(file_name, "rb")
    fsppl = Chem.ForwardSDMolSupplier(f, sanitize=False)
    if outname != None:
        out_file = gzip.open(outname, "wb")

    for mol in fsppl:
        if mol is not None:# some compounds cannot be loaded.

            # Archit solution to wrong valence error
            mol.UpdatePropertyCache(strict=False)
            ps = Chem.DetectChemistryProblems(mol)
            if ps:
                for p in ps:
                    # print(f"Error is {p}")
                    if p.GetType()=='AtomValenceException':
                        at = mol.GetAtomWithIdx(p.GetAtomIdx())
                        if at.GetAtomicNum()==7 and at.GetFormalCharge()==0 and at.GetExplicitValence()>=4:
                            at.SetFormalCharge(1)

            Chem.SanitizeMol(mol)
            Chem.Kekulize(mol)
            mol = Chem.RemoveHs(mol)
            smi = Chem.MolToSmiles(mol, kekuleSmiles=True)
            name = mol.GetProp("_Name")
            
            if outname is None:
                print(f"{smi}\t{name}")
            else: 
                out_file.write(f"{smi}\t{name}\n".encode())


    if outname != None:
        out_file.close()

if __name__ == "__main__":
    infile = sys.argv[1]
    outdir = '/dev/shm/' + sys.argv[1]
    os.makedirs(outdir, exist_ok=True)

    # the input is a file w a list of sdf file base names
    call_count = 0
    with open(infile) as f:
        for line in f:
              line = line.rstrip()
              parts = os.path.split(line)

              if os.path.exists(outdir + '/' + parts[0]) == False:
                  print("creating {}/{}".format(outdir, parts[0]))
                  os.makedirs(outdir + '/' + parts[0])

              outname = outdir + '/' + parts[0] + "/" + parts[1] + '.smi.gz'

              call_count = call_count + 1
              converter(line + '.sdf.tgz', outname=outname)

    print('CALL_COUNT = {}'.format(call_count))

