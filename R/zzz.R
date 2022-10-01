
#' @importFrom cachem cache_mem
#' @importFrom memoise memoise timeout
.onLoad <- function(libname, pkgname) {

  memoise_option <- getOption("valorantr.cache", default = TRUE)
  if (isFALSE(is.logical(memoise_option))) {
    memoise_option <- TRUE
  }
  
  if (isTRUE(memoise_option)) {
    one_day <- 60 * 60 * 24
    cache <- cachem::cache_mem()
    cache_function <- function(f, name = deparse(substitute(f))) {
      assign(
        x = name,
        value = memoise::memoise(
          f,
          ~memoise::timeout(one_day),
          cache = cache
        )
      )
    }
    cache_function(get_all_map_names)
    cache_function(get_all_weapon_names)
    cache_function(get_all_agent_names)
    cache_function(get_all_region_names)
    cache_function(get_all_team_names)
  }
}
