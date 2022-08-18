import pandas as pd
import argparse

psr = argparse.ArgumentParser(description="input csv file")
psr.add_argument("--in_file", default="df")
args = vars(psr.parse_args())

print(args)


