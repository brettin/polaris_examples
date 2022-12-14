import argparse

psr = argparse.ArgumentParser(description="input dataframe file")
psr.add_argument("--infile", default="df.csv") # world rank
args = vars(psr.parse_args())

print(args)

import sys
import os
import tensorflow as tf
from tensorflow import keras
print('{}: using tensorflow {}'.format(os.getenv('PMI_RANK'), tf.__version__))

strategy = tf.distribute.MirroredStrategy()
print('{}: Number of devices: {}'.format(os.getenv('PMI_RANK'), strategy.num_replicas_in_sync))

with strategy.scope():
    print("{}: defining and compiling model".format(os.getenv('PMI_RANK')))
    # your model is defined here
    # your model is compiled here

print("{}: calling model.fit".format(os.getenv('PMI_RANK')))
# define call backs
# call model.fit

print("{}: done calling model.fit".format(os.getenv('PMI_RANK')))
