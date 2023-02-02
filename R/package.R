#---------------------------------------------------------------------------------
# An alternative way of configuration - not tested on CRAN yet - is the following:
#   https://github.com/rstudio/reticulate/issues/883#issuecomment-775552812
#   https://github.com/kevinushey/usespandas/blob/master/DESCRIPTION
#   https://github.com/kevinushey/usespandas/blob/master/R/zzz.R
#---------------------------------------------------------------------------------


NMSLIB <- NULL; SCP <- NULL;

.onLoad <- function(libname, pkgname) {

  # reticulate::configure_environment(pkgname, force = TRUE)               # this R programming line is related to the weblinks at the top of the file (see also the documentation)

  try({
    if (reticulate::py_available(initialize = FALSE)) {

      try({
        NMSLIB <<- reticulate::import("nmslib", delay_load = TRUE)
      }, silent=TRUE)

      try({
        SCP <<- reticulate::import("scipy", delay_load = TRUE, convert = FALSE)
      }, silent=TRUE)
    }
  }, silent=TRUE)
}


.onAttach <- function(libname, pkgname) {
  packageStartupMessage("If the 'nmslibR' package gives the following error: 'attempt to apply non-function' then make sure to open a new R session and run 'reticulate::py_config()' before loading the package!")
}
