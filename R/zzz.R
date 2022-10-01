
#' @importFrom cachem cache_mem
#' @importFrom memoise memoise timeout
.onLoad <- function(libname, pkgname) {

  memoise_option <- getOption("valorantr.cache", default = "memory")
  if (!(memoise_option %in% c("memory", "off"))) {
    memoise_option <- "memory"
  }
  
  if (memoise_option == "memory") {
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
