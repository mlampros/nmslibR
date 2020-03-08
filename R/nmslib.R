

#' conversion of an R matrix to a scipy sparse matrix
#'
#'
#' @param x a data matrix
#' @param format a character string. Either \emph{"sparse_row_matrix"} or \emph{"sparse_column_matrix"}
#' @details
#' This function allows the user to convert an R matrix to a scipy sparse matrix. This is useful because the \emph{nmslibR} package accepts only \emph{python} sparse matrices as input.
#' @export
#' @references https://docs.scipy.org/doc/scipy/reference/sparse.html
#' @examples
#'
#' if (reticulate::py_available() && reticulate::py_module_available("scipy")) {
#'
#'   library(nmslibR)
#'
#'   set.seed(1)
#'
#'   x = matrix(runif(1000), nrow = 100, ncol = 10)
#'
#'   res = mat_2scipy_sparse(x)
#'
#'   print(dim(x))
#'
#'   print(res$shape)
#' }

mat_2scipy_sparse = function(x, format = 'sparse_row_matrix') {

  if (!inherits(x, "matrix")) stop("the 'x' parameter should be of type 'matrix'", call. = F)

  if (format == 'sparse_column_matrix') {

    return(SCP$sparse$csc_matrix(x))}

  else if (format == 'sparse_row_matrix') {

    return(SCP$sparse$csr_matrix(x))}

  else {

    stop("the function can take either a 'sparse_row_matrix' or a 'sparse_column_matrix' for the 'format' parameter as input", call. = F)
  }
}



#' conversion of an R sparse matrix to a scipy sparse matrix
#'
#'
#' @param R_sparse_matrix an R sparse matrix. Acceptable input objects are either a \emph{dgCMatrix} or a \emph{dgRMatrix}.
#' @details
#' This function allows the user to convert either an R \emph{dgCMatrix} or a \emph{dgRMatrix} to a scipy sparse matrix (\emph{scipy.sparse.csc_matrix} or \emph{scipy.sparse.csr_matrix}). This is useful because the \emph{nmslibR} package accepts besides an R dense matrix also python sparse matrices as input.
#'
#' The \emph{dgCMatrix} class is a class of sparse numeric matrices in the compressed, sparse, \emph{column-oriented format}. The \emph{dgRMatrix} class is a class of sparse numeric matrices in the compressed, sparse, \emph{column-oriented format}.
#'
#' @export
#' @import reticulate
#' @importFrom Matrix Matrix
#' @references https://stat.ethz.ch/R-manual/R-devel/library/Matrix/html/dgCMatrix-class.html, https://stat.ethz.ch/R-manual/R-devel/library/Matrix/html/dgRMatrix-class.html, https://docs.scipy.org/doc/scipy/reference/generated/scipy.sparse.csc_matrix.html#scipy.sparse.csc_matrix
#' @examples
#'
#' if (reticulate::py_available() && reticulate::py_module_available("scipy")) {
#'
#'   if (Sys.info()["sysname"] != 'Darwin') {
#'
#'     library(nmslibR)
#'
#'
#'     # 'dgCMatrix' sparse matrix
#'     #--------------------------
#'
#'     data = c(1, 0, 2, 0, 0, 3, 4, 5, 6)
#'
#'     dgcM = Matrix::Matrix(data = data, nrow = 3,
#'
#'                           ncol = 3, byrow = TRUE,
#'
#'                           sparse = TRUE)
#'
#'     print(dim(dgcM))
#'
#'     res = TO_scipy_sparse(dgcM)
#'
#'     print(res$shape)
#'
#'
#'     # 'dgRMatrix' sparse matrix
#'     #--------------------------
#'
#'     dgrM = as(dgcM, "RsparseMatrix")
#'
#'     print(dim(dgrM))
#'
#'     res_dgr = TO_scipy_sparse(dgrM)
#'
#'     print(res_dgr$shape)
#'   }
#' }

TO_scipy_sparse = function(R_sparse_matrix) {

  if (inherits(R_sparse_matrix, "dgCMatrix")) {

    py_obj = SCP$sparse$csc_matrix(reticulate::tuple(R_sparse_matrix@x, R_sparse_matrix@i, R_sparse_matrix@p), shape = reticulate::tuple(R_sparse_matrix@Dim[1], R_sparse_matrix@Dim[2]))
  }

  else if (inherits(R_sparse_matrix, "dgRMatrix")) {

    py_obj = SCP$sparse$csr_matrix(reticulate::tuple(R_sparse_matrix@x, R_sparse_matrix@j, R_sparse_matrix@p), shape = reticulate::tuple(R_sparse_matrix@Dim[1], R_sparse_matrix@Dim[2]))
  }

  else {

    stop("the 'R_sparse_matrix' parameter should be either a 'dgCMatrix' or a 'dgRMatrix' sparse matrix", call. = F)
  }

  return(py_obj)
}



#' Non metric space library
#'
#'
#' @param input_data the input data. See \emph{details} for more information
#' @param query_data_row a vector to query for
#' @param query_data the query_data parameter should be of the same type with the \emph{input_data} parameter. Queries to query for
#' @param k an integer. The number of neighbours to return
#' @param Index_Params a list of (optional) parameters to use in indexing (when creating the index)
#' @param Time_Params a list of parameters to use in querying. Setting \emph{Time_Params} to NULL will reset
#' @param space a character string (optional). The metric space to create for this index. Page 31 of the manual (see \emph{references}) explains all available inputs
#' @param space_params a list of (optional) parameters for configuring the space. See the \emph{references} manual for more details.
#' @param method a character string specifying the index method to use
#' @param data_type a character string. One of 'DENSE_UINT8_VECTOR', 'DENSE_VECTOR', 'OBJECT_AS_STRING' or 'SPARSE_VECTOR'
#' @param dtype a character string. Either 'FLOAT' or 'INT'
#' @param print_progress a boolean (either TRUE or FALSE). Whether or not to display progress bar
#' @param num_threads an integer. The number of threads to use
#' @param index_filepath a character string specifying the path to a file, where an existing index is saved
#' @param filename a character string specifying the path. The filename to save ( in case of the \emph{save_Index} method ) or the filename to load ( in case of the \emph{load_Index} method )
#' @export
#' @details
#'
#' \emph{input_data} parameter : In case of numeric data the \emph{input_data} parameter should be either an R matrix object or a scipy sparse matrix. Additionally, the \emph{input_data} parameter can be a list including more than one matrices / sparse-matrices having the same number of columns ( this is ideal for instance if the user wants to include both a train and a test dataset in the created index )
#'
#' the \emph{Knn_Query} function finds the approximate K nearest neighbours of a vector in the index
#'
#' the \emph{knn_Query_Batch} Performs multiple queries on the index, distributing the work over a thread pool
#'
#' the \emph{save_Index} function saves the index to disk
#'
#' If the \emph{index_filepath} parameter is not NULL then an existing index will be loaded
#'
#' @references \emph{https://github.com/nmslib/nmslib/blob/master/manual/latex/manual.pdf}
#' @docType class
#' @importFrom R6 R6Class
#' @import reticulate
#' @section Methods:
#'
#' \describe{
#'  \item{\code{NMSlib$new(input_data, Index_Params = NULL, Time_Params = NULL, space='l1',
#'                         space_params = NULL, method = 'hnsw', data_type = 'DENSE_VECTOR',
#'                         dtype = 'FLOAT', index_filepath = NULL, print_progress = FALSE)}}{}
#'
#'  \item{\code{--------------}}{}
#'
#'  \item{\code{Knn_Query(query_data_row, k = 5)}}{}
#'
#'  \item{\code{--------------}}{}
#'
#'  \item{\code{knn_Query_Batch(query_data, k = 5, num_threads = 1)}}{}
#'
#'  \item{\code{--------------}}{}
#'
#'  \item{\code{save_Index(filename)}}{}
#'  }
#'
#' @usage # init <- NMSlib$new(input_data, Index_Params = NULL, Time_Params = NULL,
#' #                           space='l1', space_params = NULL, method = 'hnsw',
#' #                           data_type = 'DENSE_VECTOR', dtype = 'FLOAT',
#' #                           index_filepath = NULL, print_progress = FALSE)
#' @examples
#'
#' if (reticulate::py_available() && reticulate::py_module_available("nmslib")) {
#'
#'   library(nmslibR)
#'
#'   set.seed(1)
#'   x = matrix(runif(1000), nrow = 100, ncol = 10)
#'
#'   init_nms = NMSlib$new(input_data = x)
#'
#'
#'   # returns a 1-dimensional vector (index, distance)
#'   #--------------------------------------------------
#'
#'   init_nms$Knn_Query(query_data_row = x[1, ], k = 5)
#'
#'
#'   # returns knn's for all data
#'   #---------------------------
#'
#'   all_dat = init_nms$knn_Query_Batch(x, k = 5, num_threads = 1)
#'
#' }


NMSlib <- R6::R6Class("NMSlib",

                      lock_objects = FALSE,

                       public = list(

                         initialize = function(input_data, Index_Params = NULL, Time_Params = NULL, space='l1', space_params = NULL, method = 'hnsw',

                                               data_type = 'DENSE_VECTOR', dtype = 'FLOAT', index_filepath = NULL, print_progress = FALSE) {


                           if (inherits(input_data, "data.frame")) stop("the 'input_data' parameter is a data frame. For the function to run error free convert the data frame to a matrix", call. = F)


                           # eval-parse to convert string to a variable
                           #-------------------------------------------

                           DATA_TYPE = NMSLIB$DataType
                           data_type = eval(parse(text = paste('DATA_TYPE$', data_type, sep = "", collapse = "")))

                           DTYPE = NMSLIB$DistType
                           dtype = eval(parse(text = paste('DTYPE$', dtype, sep = "", collapse = "")))



                           # initialization of nmslib
                           #-------------------------

                           if (!is.null(space_params)) {

                             space_params = reticulate::dict(space_params)
                           }

                           private$index = NMSLIB$init(space=space, space_params = space_params, method = method, data_type = data_type, dtype = dtype)


                           # by default data points will be inserted in batches [not single points] to the index AND also account for the fact that 'input_data' can be a list object
                           #------------------------------------------------------------------------------------     ----------------------------------------------------------------

                           if (inherits(input_data, "list")) {

                             for (ITEM in 1:length(input_data)) {

                               private$index$addDataPointBatch(input_data[[ITEM]])                    # here it's important, in case of matrices, that the columns of each object are equal, otherwise it will throw an error
                             }
                           }

                           else {

                             private$index$addDataPointBatch(input_data)
                           }


                           # "createIndex" OR load from a file-path an already saved index
                           #---------------------------------------------------------------

                           if (is.null(index_filepath)) {                                      # if filepath is NULL create index, ...

                             if (is.null(Index_Params)) {

                               private$index$createIndex( print_progress = print_progress )}

                             else {

                               private$index$createIndex( reticulate::dict(Index_Params), print_progress = print_progress )
                             }
                           }

                           else {                                                             # ... else, load existing index from filepath

                             private$index$loadIndex(index_filepath, print_progress)          # loads the index from disk
                           }


                           # 'setQueryTimeParams' function     [ Sets parameters used in 'knnQuery' and 'knnQueryBatch' ]
                           #------------------------------

                           if (is.null(Time_Params)) {

                             private$index$setQueryTimeParams( Time_Params )}

                           else {

                             private$index$setQueryTimeParams( reticulate::dict(Time_Params) )
                           }
                         },


                         # 'knnQuery' function       [ returns index and distance for a single row -- Finds the approximate (or exact when brute force is used) K nearest neighbours of a vector in the index ]
                         #--------------------

                         Knn_Query = function(query_data_row, k = 5) {

                           idx_dists_single_ROW = private$index$knnQuery(query_data_row, as.integer(k + 1))             # add 1 because I'll remove the first item ( see next line )

                           indices = idx_dists_single_ROW[[1]]
                           indices = indices[-1] + 1                                                                    # remove the first item as it represents the distance between a row with itself   &   account for the indexing differences betw. Python and R

                           values = idx_dists_single_ROW[[2]]
                           values = values[-1]

                           return(list(indices, values))
                         },


                         # 'knnQueryBatch' function     [ Performs multiple queries on the index, distributing the work over a thread pool ]
                         #-------------------------

                         knn_Query_Batch = function(query_data, k = 5, num_threads = 1) {

                           if (inherits(query_data, "data.frame")) stop("the 'query_data' parameter is a data frame. For the function to run error free convert the data frame to a matrix", call. = F)

                           tmp_lst = private$index$knnQueryBatch(query_data, as.integer(k + 1), as.integer(num_threads))        # add 1 to account for the indexing differences betw. Python and R  [ adjusted also in the Rcpp function ]

                           idx_dists_ = nmslib_idx_dist(tmp_lst, k, num_threads)                                                # Rcpp function [ parallelized ]

                           return(idx_dists_)
                         },


                         # 'saveIndex' function               [ Saves the index to disk ]
                         #---------------------

                         save_Index = function(filename) {

                           private$index$saveIndex(filename)

                           invisible()
                         }
                       ),

                       private = list(

                         index = NULL
                       )
)



#' import internal functions from the KernelKnn package
#'
#' @importFrom utils getFromNamespace
#' @keywords internal

import_internal = function(function_name) {

  utils::getFromNamespace(function_name, "KernelKnn")
}



#' inner function to compute kernels, extract weights and return predictions
#'
#' @keywords internal

inner_kernel_function = function(y_matrix, dist_matrix, Levels, weights_function, h) {

  #------------------------------------ import internal functions from KernelKnn

  normalized = import_internal('normalized')
  func_tbl_dist = import_internal('func_tbl_dist')
  func_tbl = import_internal('func_tbl')
  FUNCTION_weights = import_internal('FUNCTION_weights')
  switch_secondary = import_internal('switch_secondary')
  switch.ops = import_internal('switch.ops')
  FUN_kernels = import_internal('FUN_kernels')
  func_categorical_preds = import_internal('func_categorical_preds')
  func_shuffle = import_internal('func_shuffle')
  class_folds = import_internal('class_folds')
  regr_folds = import_internal('regr_folds')

  #------------------------------------

  if (is.null(Levels)) {                                                          # regression

    if (is.null(weights_function)) {

      out_ = rowMeans(y_matrix)
    }

    else if (is.function(weights_function)) {

      W_te = FUNCTION_weights(dist_matrix, weights_function)

      out_ = rowSums(y_matrix * W_te)
    }

    else if (is.character(weights_function) && nchar(weights_function) > 1) {

      W_te = FUN_kernels(weights_function, dist_matrix, h)

      out_ = rowSums(y_matrix * W_te)
    }

    else {

      stop('false input for the weights_function argument')
    }
  }

  else {                                                                          # classification

    if (is.null(weights_function)) {

      out_ = func_tbl_dist(y_matrix, sort(Levels))

      colnames(out_) = paste0('class_', sort(Levels))}

    else if (is.function(weights_function)) {

      W_te = FUNCTION_weights(dist_matrix, weights_function)

      out_ = func_tbl(y_matrix, W_te, sort(Levels))}

    else if (is.character(weights_function) && nchar(weights_function) > 1) {

      W_te = FUN_kernels(weights_function, dist_matrix, h)

      out_ = func_tbl(y_matrix, W_te, sort(Levels))}

    else {

      stop('false input for the weights_function argument')
    }
  }

  return(out_)
}




#' Approximate Kernel k nearest neighbors using the nmslib library
#'
#'
#' @param data either a matrix or a scipy sparse matrix
#' @param TEST_data a test dataset (in case of a matrix the \emph{TEST_data} should have equal number of columns with the \emph{data}). It is assumed that the \emph{TEST_data} is an unlabeled dataset
#' @param y a numeric vector specifying the response variable (in classification the labels must be numeric from 1:Inf). The length of \emph{y} must equal the rows of the \emph{data} parameter
#' @param k an integer. The number of neighbours to return
#' @param h the bandwidth (applicable if the weights_function is not NULL, defaults to 1.0)
#' @param weights_function there are various ways of specifying the kernel function. See the details section.
#' @param Levels a numeric vector. In case of classification the unique levels of the response variable are necessary
#' @param Index_Params a list of (optional) parameters to use in indexing (when creating the index)
#' @param Time_Params a list of parameters to use in querying. Setting \emph{Time_Params} to NULL will reset
#' @param space a character string (optional). The metric space to create for this index. Page 31 of the manual (see \emph{references}) explains all available inputs
#' @param space_params a list of (optional) parameters for configuring the space. See the \emph{references} manual for more details.
#' @param method a character string specifying the index method to use
#' @param data_type a character string. One of 'DENSE_UINT8_VECTOR', 'DENSE_VECTOR', 'OBJECT_AS_STRING' or 'SPARSE_VECTOR'
#' @param dtype a character string. Either 'FLOAT' or 'INT'
#' @param print_progress a boolean (either TRUE or FALSE). Whether or not to display progress bar
#' @param num_threads an integer. The number of threads to use
#' @param index_filepath a character string specifying the path to a file, where an existing index is saved
#' @details
#' There are three possible ways to specify the \emph{weights function}, 1st option : if the weights_function is NULL then a simple k-nearest-neighbor is performed. 2nd option : the weights_function is one of 'uniform', 'triangular', 'epanechnikov', 'biweight', 'triweight', 'tricube', 'gaussian', 'cosine', 'logistic', 'gaussianSimple', 'silverman', 'inverse', 'exponential'. The 2nd option can be extended by combining kernels from the existing ones (adding or multiplying). For instance, I can multiply the tricube with the gaussian kernel by giving 'tricube_gaussian_MULT' or I can add the previously mentioned kernels by giving 'tricube_gaussian_ADD'. 3rd option : a user defined kernel function
#' @export
#' @examples
#'
#' if (reticulate::py_available() && reticulate::py_module_available("nmslib")) {
#'
#'   library(nmslibR)
#'
#'   x = matrix(runif(1000), nrow = 100, ncol = 10)
#'
#'   y = runif(100)
#'
#'   out = KernelKnn_nmslib(data = x, y = y, k = 5)
#' }


KernelKnn_nmslib = function(data, TEST_data = NULL, y, k = 5, h = 1.0, weights_function = NULL, Levels = NULL, Index_Params = NULL,

                            Time_Params = NULL, space='l1', space_params = NULL, method = 'hnsw', data_type = 'DENSE_VECTOR',

                            dtype = 'FLOAT', index_filepath = NULL, print_progress = FALSE, num_threads = 1) {

  if (inherits(data, "data.frame")) stop("the 'data' parameter is a data frame. For the function to run error free convert the data frame to a matrix", call. = F)

  if (!is.null(TEST_data)) {

    if (inherits(TEST_data, "data.frame")) stop("the 'TEST_data' parameter is a data frame. For the function to run error free convert the data frame to a matrix", call. = F)
  }

  init_nmslib = NMSlib$new(input_data = data, Index_Params, Time_Params, space, space_params, method, data_type, dtype, index_filepath, print_progress)

  if (!is.null(TEST_data)) {

    knn_idx_dist = init_nmslib$knn_Query_Batch(TEST_data, k, num_threads)}

  else {

    knn_idx_dist = init_nmslib$knn_Query_Batch(data, k, num_threads)
  }

  out_y = y_idxs(knn_idx_dist$knn_idx, y, num_threads)

  if (!check_NaN_Inf(out_y)) {

    warning("the output includes missing values", call. = F)                                   # in first place just print a warning in case of missing values
  }

  out_ = inner_kernel_function(out_y, knn_idx_dist$knn_dist, Levels, weights_function, h)

  return(out_)
}





#' Approximate Kernel k nearest neighbors (cross-validated) using the nmslib library
#'
#'
#' @param data a numeric matrix
#' @param y a numeric vector specifying the response variable (in classification the labels must be numeric from 1:Inf). The length of \emph{y} must equal the rows of the \emph{data} parameter
#' @param k an integer. The number of neighbours to return
#' @param folds the number of cross validation folds (must be greater than 1)
#' @param h the bandwidth (applicable if the weights_function is not NULL, defaults to 1.0)
#' @param weights_function there are various ways of specifying the kernel function. See the details section.
#' @param Levels a numeric vector. In case of classification the unique levels of the response variable are necessary
#' @param Index_Params a list of (optional) parameters to use in indexing (when creating the index)
#' @param Time_Params a list of parameters to use in querying. Setting \emph{Time_Params} to NULL will reset
#' @param space a character string (optional). The metric space to create for this index. Page 31 of the manual (see \emph{references}) explains all available inputs
#' @param space_params a list of (optional) parameters for configuring the space. See the \emph{references} manual for more details.
#' @param method a character string specifying the index method to use
#' @param data_type a character string. One of 'DENSE_UINT8_VECTOR', 'DENSE_VECTOR', 'OBJECT_AS_STRING' or 'SPARSE_VECTOR'
#' @param dtype a character string. Either 'FLOAT' or 'INT'
#' @param print_progress a boolean (either TRUE or FALSE). Whether or not to display progress bar
#' @param num_threads an integer. The number of threads to use
#' @param index_filepath a character string specifying the path to a file, where an existing index is saved
#' @param seed_num a numeric value specifying the seed of the random number generator
#' @details
#' There are three possible ways to specify the \emph{weights function}, 1st option : if the weights_function is NULL then a simple k-nearest-neighbor is performed. 2nd option : the weights_function is one of 'uniform', 'triangular', 'epanechnikov', 'biweight', 'triweight', 'tricube', 'gaussian', 'cosine', 'logistic', 'gaussianSimple', 'silverman', 'inverse', 'exponential'. The 2nd option can be extended by combining kernels from the existing ones (adding or multiplying). For instance, I can multiply the tricube with the gaussian kernel by giving 'tricube_gaussian_MULT' or I can add the previously mentioned kernels by giving 'tricube_gaussian_ADD'. 3rd option : a user defined kernel function
#' @export
#' @importFrom utils txtProgressBar
#' @importFrom utils setTxtProgressBar
#' @examples
#'
#' \dontrun{
#' x = matrix(runif(1000), nrow = 100, ncol = 10)
#'
#' y = runif(100)
#'
#' out = KernelKnnCV_nmslib(x, y, k = 5, folds = 5)
#' }


KernelKnnCV_nmslib = function(data, y, k = 5, folds = 5, h = 1.0, weights_function = NULL, Levels = NULL, Index_Params = NULL,

                              Time_Params = NULL, space='l1', space_params = NULL, method = 'hnsw', data_type = 'DENSE_VECTOR',

                              dtype = 'FLOAT', index_filepath = NULL, print_progress = FALSE, num_threads = 1, seed_num = 1) {

  start = Sys.time()

  #------------------------------------ import internal functions from KernelKnn

  class_folds = import_internal('class_folds')
  regr_folds = import_internal('regr_folds')

  #------------------------------------

  if (is.null(Levels)) {

    set.seed(seed_num)
    n_folds = regr_folds(folds, y)}

  else {

    set.seed(seed_num)
    n_folds = class_folds(folds, as.factor(y))
  }

  if (!all(unlist(lapply(n_folds, length)) > 5)) stop('Each fold has less than 5 observations. Consider decreasing the number of folds or increasing the size of the data.')

  tmp_fit = list()

  cat('\n') ; cat('cross-validation starts ..', '\n')

  pb <- txtProgressBar(min = 0, max = folds, style = 3); cat('\n')

  for (i in 1:folds) {

    tmp_fit[[i]] = KernelKnn_nmslib(data = data[unlist(n_folds[-i]), ], TEST_data = data[unlist(n_folds[i]), ], y = y[unlist(n_folds[-i])], k, h,

                                    weights_function, Levels, Index_Params, Time_Params, space, space_params, method, data_type,

                                    dtype, index_filepath, print_progress, num_threads)

    setTxtProgressBar(pb, i)
  }

  close(pb); cat('\n')

  end = Sys.time()

  t = end - start

  cat('time to complete :', t, attributes(t)$units, '\n'); cat('\n');

  return(list(preds = tmp_fit, folds = n_folds))
}


