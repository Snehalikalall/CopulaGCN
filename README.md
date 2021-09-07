# CopulaGCN

A topology preserving graph convolution network for clustering of single-cell RNA seq data

## Pre-requisites

> R version  4.0.2

> Python 3.7

> Python packages: sklearn-0.19.2, multiprocessing, tensorflow 2.0

> R packages: copula, foreach, doParallel

## Install
library("devtools")

install_github("Snehalikalall/CopulaGCN")

Check the installation:

library(copulagcn)

## Load required packages

R packages

     library(SingleCellExperiment)
     library(foreach)
     library(doParallel)
     library(Linnorm)
     library(copula)

Python Packages: 
 
    pip install -U scikit-learn==0.19.2
    pip install multiprocess



## Preprocessing of raw data

Preprocess the raw data using DataProcessing.R function

    Biase_data<- readRDS("klein.rds")
    data <- assay(Biase_data) 
    annotation <- Biase_data[[1]] #already factor type class
    colnames(data) <- annotation
    data_process = normalized_data(data)
    write.table(t(data_process),file="UCFS/Data/data_process.csv",sep=",",row.names = FALSE,col.names = FALSE)

## Use LSH smpling

Run LSPCAnew.py to select a sub-sample of genes as:  python LSPCAnew.py 

The function returns the sampled data "lspcadata.csv" 

## Get copula based cell-cell correlation matrix from sampled data 

Use copula_cell_cell_similarmatrix.R to get the cell-cell correlation matrix.

    # load the "lspcadata.csv" in R file (#should be genes in row, cells in coloumn).  
    lspcadata<-as.matrix(read.csv("Data/lspcadata.csv",header=FALSE))
    p=40
    
    #P: Number of cores, default is 40

    # Copula based cell cell correlation matrix generation, the function returns (cellxcell) matrix
    Result=copulacellmatrix(lspcadata,p)
    
## Get low dimensional embedding from copula based cell-cell correlation matrix 
    
    Use GCN_on_copulamat.ipynb to get the low dimensional embedding matrix.
    
   
