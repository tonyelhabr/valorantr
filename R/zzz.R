
.onLoad <- function(libname, pkgname) {
  if (is.null(getOption("valorantr.verbose"))) {
    options("valorantr.verbose" = TRUE)
  }
}
