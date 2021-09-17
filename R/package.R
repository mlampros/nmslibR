#-------------------------
# Load the python-modules
#-------------------------


NMSLIB <- NULL; SCP <- NULL;


.onLoad <- function(libname, pkgname) {

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
