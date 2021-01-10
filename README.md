# UCFS
Download the Raw Example dataset (yan.rds). Put the dataset and codes in same folder.

Run the **preprocessing.R** file to preprocess your raw datasets.  There are three user parameters: min_Reads, min_Cell, min_Gene. 

Run the  **LSPCAnew.py** python script to sampling the genes.  It takes the pre-processed dataset as input and returns the sampled feature dataset as output, **datasemifea.csv** file is the output. 

The user input for number of iterations(k) in LSH is given **3** as default for example dataset. It can be changed by users depending upon size on datasets. Default is **2** for small datasets, or **3** for large feature dataset.


Run  the **main.R** script directly as a sampled feature dataset, which is also given in data folder.

The user input for number of features to be selected using UCFS is given. **100** as default for the example dataset. 

Output **Feaout** is the informative feature subset.

## Pre-requisites

> R version  4.0.2

> Python 3.7

> Python packages: sklearn-0.19.2, multiprocessing

> R packages: copula, infotheo, foreach, doParallel
