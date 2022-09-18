
#' Load a .qs file from a URL
#' 
#' @param url URL
#' @importFrom curl curl_fetch_memory
#' @importFrom qs qdeserialize
#' @source <https://github.com/nflverse/nflreadr/blob/main/R/from_url.R#L185>
#' @export
qs_from_url <- function(url) {
  load <- curl::curl_fetch_memory(url)
  qs::qdeserialize(load$content)
}

#' Load a valorant-data release
#' 
#' @param tag Tag of release in valorant-data
#' @export
load_valorant <- function(tag) {
  url <- sprintf('https://github.com/tonyelhabr/valorant-data/releases/download/%s/%s.qs', tag, tag)
  qs_from_url(url)
}
