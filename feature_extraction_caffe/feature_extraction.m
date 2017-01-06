#set up Python environment: numpy for numerical routines, and matplotlib for plotting
import numpy as np
import matplotlib.pyplot as plt
import math
# display plots in this notebook


# set display defaults
plt.rcParams['figure.figsize'] = (10, 10)        # large images
plt.rcParams['image.interpolation'] = 'nearest'  # don't interpolate: show square pixels
plt.rcParams['image.cmap'] = 'gray'  # use grayscale output rather than a (potentially misleading) color heatmap


# The caffe module needs to be on the Python path;
#  we'll add it here explicitly.
import sys
caffe_root = '/...'  # this file should be run from {caffe_root}/examples (otherwise change this line)
sys.path.insert(0, caffe_root + 'python')

import caffe
import os
if os.path.isfile(caffe_root + 'models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel'):
    print 'CaffeNet found.'
else:
    print 'Downloading pre-trained CaffeNet model...'
caffe.set_mode_cpu()

model_def = caffe_root + 'models/bvlc_reference_caffenet/deploy.prototxt'
model_weights = caffe_root + 'models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel'

net = caffe.Net(model_def,      # defines the structure of the model
                model_weights,  # contains the trained weights
                caffe.TEST)     # use test mode (e.g., don't perform dropout)


# load the mean ImageNet image (as distributed with Caffe) for subtraction
mu = np.load(caffe_root + 'python/caffe/imagenet/ilsvrc_2012_mean.npy')
mu = mu.mean(1).mean(1)  # average over pixels to obtain the mean (BGR) pixel values
print 'mean-subtracted values:', zip('BGR', mu)

# create transformer for the input called 'data'
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})

transformer.set_transpose('data', (2,0,1))  # move image channels to outermost dimension
transformer.set_mean('data', mu)            # subtract the dataset-mean value in each channel
transformer.set_raw_scale('data', 255)      # rescale from [0, 1] to [0, 255]
transformer.set_channel_swap('data', (2,1,0))  # swap channels from RGB to BGR

# set the size of the input (we can skip this if we're happy
#  with the default; we can also change it later, e.g., for different batch sizes)
net.blobs['data'].reshape(10,        # batch size
                          3,         # 3-channel (BGR) images
                          227, 227)  # image size is 227x227

import os
import scipy.io as sio
import numpy as np


# get all the images in the 'all' folder.
def getAllImages(folder):
    assert os.path.exists(folder)
    assert os.path.isdir(folder)
    imageList = os.listdir(folder)

    return imageList


print getAllImages("...")

imageList=getAllImages("/...")
pid=0
brandsize=len(imageList)
roundnum =int (math.ceil(brandsize/10))
returnmat=np.zeros((brandsize, 4096))

for i in range(0,roundnum):

    j=0
    while j<10:

        image_root='/...'+imageList[pid]

        image = caffe.io.load_image(image_root)
        transformed_image = transformer.preprocess('data', image)
        net.blobs['data'].data[j]=transformed_image
        j=j+1
        pid=pid+1

    #GPU mode
    caffe.set_device(0)  # if we have multiple GPUs, pick the first one
    caffe.set_mode_gpu()
    net.forward()  # run once before timing to set up memory

    feat = net.blobs['fc6'].data
    returnmat[i*10:i*10+10,:]=feat
#print returnmat[1,:]


sio.savemat('...',{'data':returnmat[0:75484,:]})

sio.savemat('/...',{'data':returnmat[75484:150968,:]})



















