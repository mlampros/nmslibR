
## nmslibR 1.0.4

I adjusted the output indices of the *Knn_Query* method (*NMSlib* R6 class) to account for the difference in indexing between R and Python ( *reference* : https://github.com/mlampros/nmslibR/issues/5 )


## nmslibR 1.0.3

I updated the README.md file and especially the installation instructions for all mentioned operating systems i.e. Linux, Macintosh, Windows (switch from python2 to python3 due to pybind11 issues).


## nmslibR 1.0.2

* The *dgCMatrix_2scipy_sparse* function was renamed to *TO_scipy_sparse* and now accepts either a *dgCMatrix* or a *dgRMatrix* as input. The appropriate format for the nmslibR package in case of sparse matrices is the *dgRMatrix* format (*scipy.sparse.csr_matrix*)
* I added an onload.R file to inform the users about the previous change [ related with the issue : https://github.com/mlampros/nmslibR/issues/1 ]
* I removed the *utils.R* file which included internal functions of the *KernelKnn* package. Rather than including the file I now use the *getFromNamespace* function of the *utils* package.
* Due to the previous changes I modified the Vignette and the tests too.


## nmslibR 1.0.1

* I commented the example(s) and test(s) related to the *dgCMatrix_2scipy_sparse* function [ *if (Sys.info()["sysname"] != 'Darwin')* ], because the *scipy-sparse* library on CRAN is not upgraded and the older version includes a bug (*TypeError : could not interpret data type*). This leads to an error on *Macintosh* Operating System ( *reference* : https://github.com/scipy/scipy/issues/5353 )
* I added links to the github repository (master repository, issues)


## nmslibR 1.0.0




