import argparse

psr = argparse.ArgumentParser(description="input dataframe file")
psr.add_argument("--infile", default="df.csv") # world rank
args = vars(psr.parse_args())

print(args)

import sys
import tensorflow as tf
from tensorflow import keras
print('using tensorflow {}'.format(tf.__version__))

strategy = tf.distribute.MirroredStrategy()
print('Number of devices: {}'.format(strategy.num_replicas_in_sync))

with strategy.scope():
    print("defining and compiling model")
    # your model is defined here
    # your model is compiled here

print("calling model.fit")
# define call backs
# call model.fit
