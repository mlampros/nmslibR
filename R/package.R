#-------------------------
# Load the python-modules
#-------------------------


NMSLIB <- NULL; SCP <- NULL;


.onLoad <- function(libname, pkgname) {

  if (reticulate::py_available(initialize = TRUE)) {

    if (reticulate::py_module_available("nmslib")) {

      NMSLIB <<- reticulate::import("nmslib", delay_load = TRUE)
    }

    if (reticulate::py_module_available("scipy")) {

      SCP <<- reticulate::import("scipy", delay_load = TRUE, convert = FALSE)
    }
  }
}
