#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
from scipy import mean


class Lat(object):
    def __init__(self, fileName):
        f = open(fileName, 'rb')
        a = np.fromfile(f, dtype=np.uint64)
        self.reqTimes = a.reshape((int(a.shape[0]/6), 6))
        f.close()

    def parseQueueTimes(self):
        return self.reqTimes[:, 3]

    def parseSvcTimes(self):
        return self.reqTimes[:, 4]

    def parseSojournTimes(self):
        return self.reqTimes[:, 5]
    
    def parseFeature1s(self):
        return self.reqTimes[:, 0]
    
    def parseFeature2s(self):
        return self.reqTimes[:, 1]
    
    def parseFeature3s(self):
        return self.reqTimes[:, 2]
    
    def convert_to_csv(self):
        df = pd.DataFrame(self.reqTimes, columns=["feature1s", "feature2s", "feature3s", "queueTime", "serviceTime", "sojournTime"])
        df.to_csv("lats.csv")


def draw_pdf(values, nbins):
    clear()
    return pd.Series(values).hist(bins=nbins)

def savefig(pathname):
    plt.savefig(pathname)

def clear():
    plt.cla()
    plt.clf()
    plt.close()

if __name__ == '__main__':
    latsObj = Lat(sys.argv[1])
    latsObj.convert_to_csv()

