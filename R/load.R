
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
#' @param \dots Extra params to pass to `piggyback::pb_releases` to check for existing releases.
#' @importFrom piggyback pb_releases
#' @export
load_valorant <- function(tag, ...) {
  releases <- piggyback::pb_releases(valorant_repo, ...)
  release_exists <- any(tag == releases$release_name)
  if (isFALSE(release_exists)) {
    stop(sprintf('Release for `tag = "%s"` does not exist.'))
  }
  url <- sprintf('https://github.com/%s/releases/download/%s/%s.qs', valorant_repo, tag, tag)
  qs_from_url(url)
}
