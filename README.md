# UCFS

A Copula Based unsupervised Feature Selection- Application on Single cell RNA Sequence Data

## Pre-requisites

> R version  4.0.2

> Python 3.7

> Python packages: sklearn-0.19.2, multiprocessing

> R packages: copula, prodlim, foreach, doParallel

## Install
library("devtools")

install_github("Snehalikalall/UCFS")

Check the installation:

library(UCFS)

## Load required packages

R packages

     library(SingleCellExperiment)
     library(foreach)
     library(doParallel)
     library(Linnorm)

Python Packages: 
 
    pip install -U scikit-learn==0.19.2
    pip install multiprocess



## Usage of the R functions

Preprocess raw data using DataProcessing.R function

    Biase_data<- readRDS("klein.rds")
    data <- assay(Biase_data) 
    annotation <- Biase_data[[1]] #already factor type class
    colnames(data) <- annotation
    preprocessed_data = normalized_data(data)


Use Renyifeature.R to select features using Renyi entropy, Tsallisfeature.R to select features using Tsallis entropy

    # load the preprocess data. Data should be cells in row, genes in coloumn.
    data=t(as.matrix(read.csv("yan_process.csv",header=FALSE)))
    cell<-as.matrix(read.csv("yan_celltype.csv",header=FALSE))
    gene<-as.matrix(read.csv("yan_gene.csv",header=FALSE))
    n <- nrow(data)
    col<-ncol(data)
    count=ncol(data)
    p=40
    q=0.3
    nf=500
    #nf: Number of feature to be selected, default is 500; P: Number of cores, default is 40;
    # q-value = 0.3 for tsallis, q-value=0.7 for Renyi

    # Renyi entropy based Feature Selection, the function returns data with selected features
    Feadata=Renyifeature(data,cell,gene,p,q,nf)
    
    # Renyi entropy based Feature Selection, the function returns the data with selected features
    Feadata=Tsallisfeature(data,cell,gene,p,q,nf)

