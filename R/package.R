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
