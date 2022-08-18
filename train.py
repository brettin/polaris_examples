import pandas as pd
import argparse

psr = argparse.ArgumentParser(description="input dataframe file")
psr.add_argument("--infile", default="df.csv")
args = vars(psr.parse_args())

print(args)


