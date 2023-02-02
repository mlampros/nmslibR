
## nmslibR 1.0.7

* I've added the *include_query_data_row_index* parameter to the *Knn_Query()* method of the *NMSlib* R6 Class and at the same time I added a deprecation warning for this parameter, because this method currently excludes by default the first output index and value. By setting the *include_query_data_row_index* to TRUE the first output index and value will be returned. This change will take effect in version 1.1.0 and the *Knn_Query()* method will return the first output index and value by default.
* I added the *"save_data"* parameter to the *"save_Index()"* method and the *"load_data"* parameter to the *"initialize()"* method of the *'NMSlib()'* R6 class. I updated the documentation and references sections as well
* I've modified the *DESCRIPTION* and the *package.R* file by adding only comments related to a new configuration type in the reticulate R package (see: https://github.com/rstudio/reticulate/issues/883#issuecomment-775552812)
* I updated the *Makevars* and the .cpp files from C++11 to C++17 because I received the following NOTE during checking of the package: *Specified C++11: please update to current default of C++17*
* I updated the *.Rbuildignore* file to exclude the *LICENSE.md* file because it gives a NOTE during CRAN checking


## nmslibR 1.0.6

* I've added a 'packageStartupMessage' informing the user in case of the error 'attempt to apply non-function' that he/she has to use the 'reticulate::py_config()' before loading the package (in a new R session)
* I've updated the 'SystemRequirements' in the DESCRIPTION file


## nmslibR 1.0.5

* I updated the *License* in the DESCRIPTION file which as of '07-05-2021' will be *Apache License Version 2.0*. Therefore I removed also the COPYRIGHTS file from the 'inst' directory
* I removed *LazyData* from the DESCRIPTION file
* I added the *CITATION* file in the 'inst' directory
* I removed the 'zzz.R' file and the 'packageStartupMessage()'


## nmslibR 1.0.4

* I adjusted the output indices of the *Knn_Query* method (*NMSlib* R6 class) to account for the difference in indexing between R and Python ( *reference* : https://github.com/mlampros/nmslibR/issues/5 )
* I removed the *dtype* 'DOUBLE' parameter from the *NMSlib* R6 class, *KernelKnn_nmslib* and  *KernelKnnCV_nmslib* functions (*reference* : https://github.com/nmslib/nmslib/commit/4d2937d6259aebb456db141ee0f3c2c465a51a8e )
* I replaced almost all web-links of the Python *nmslib* Package because the initial repository was moved to https://github.com/nmslib/nmslib


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




