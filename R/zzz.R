
# temporary startup message beginning from version 1.0.2 [ SEE : http://r-pkgs.had.co.nz/r.html#r-differences ]

.onAttach <- function(libname, pkgname) {
  
  packageStartupMessage("Begninning from version 1.0.2 the 'dgCMatrix_2scipy_sparse' function was renamed to 'TO_scipy_sparse' and now accepts either a 'dgCMatrix' or a 'dgRMatrix' as input. The appropriate format for the 'nmslibR' package in case of sparse matrices is the 'dgRMatrix' format (scipy.sparse.csr_matrix)")
}