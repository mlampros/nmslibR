#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP _nmslibR_check_NaN_Inf(SEXP);
extern SEXP _nmslibR_nmslib_idx_dist(SEXP, SEXP, SEXP);
extern SEXP _nmslibR_y_idxs(SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_nmslibR_check_NaN_Inf",   (DL_FUNC) &_nmslibR_check_NaN_Inf,   1},
    {"_nmslibR_nmslib_idx_dist", (DL_FUNC) &_nmslibR_nmslib_idx_dist, 3},
    {"_nmslibR_y_idxs",          (DL_FUNC) &_nmslibR_y_idxs,          3},
    {NULL, NULL, 0}
};

void R_init_nmslibR(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
