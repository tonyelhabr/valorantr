
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom utils URLencode

get_ribgg <- function(x, ...) {
  sprintf("https://backend-prod.rib.gg/v1/%s", x) |> 
    httr::GET(...) |> 
    httr::content(as = "text") |> 
    jsonlite::fromJSON()
}

get_ribgg_data <- function(...) {
  resp <- get_ribgg(...)
  
  if (isTRUE(getOption("valorantr.verbose"))) {
    message(sprintf('Total of %s possible results.', resp$meta$total))
  }
  
  resp[["data"]]
}


#' Get all teams
#' 
#' Get all teams' info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' all_teams <- get_all_teams()
#' dplyr::glimpse(all_teams)
#' }
get_all_teams <- function() {
  get_ribgg("teams/all")
}

#' Get player
#' 
#' Get player info given a player ID
#' 
#' @param player_id Player ID
#' @return a list with the following elements
#' @export
#' @examples 
#' \donttest{
#' yay <- get_player()
#' dplyr::glimpse(yay)
#' }
get_player <- function(player_id) {
  sprintf("players/%s", player_id) |> 
    get_ribgg()
}

#' Get events
#' 
#' Get event ids given a free-text query
#' 
#' @details Note that sometimes the query doesn't seem to work. Results will be returned, but they are a default set of results.
#' 
#' @param query Text description of event, e.g. "VALORANT Champions 2022 Playoffs"
#' @param \dots Currently un-used
#' @param n_results Number of results to return. API tries to respect `n_results` even if event name doesn't match query. 50 is default of the API.
#' @param sort_by,ascending How to return the results
#' @param has_series Whether or not to return events with completed series
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' events <- get_events("VALORANT Champions 2022")
#' dplyr::glimpse(events)
#' }
get_events <- function(query, ..., sort_by = "startDate", ascending = FALSE, has_series = TRUE, n_results = 50) {
  stopifnot(
    is.character(query),
    length(query) == 1
  )
  sprintf(
    "events?query=%s&sort=%s&sortAscending=%s&hasSeries=%s&take=%s", 
    URLencode(query),
    sort_by,
    tolower(ascending),
    tolower(has_series),
    n_results
  ) |> 
    get_ribgg_data()
}

#' Get series
#' 
#' Get series ids for a given event
#' 
#' @param event_id Event ID
#' @param \dots Currently un-used
#' @param completed Whether or not to return completed series
#' @param n_results Number of results to return. 50 is default of the API.
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' get_series(1866) ## VALORANT Champions 2022 - Playoffs
#' }
get_series <- function(event_id, ..., completed = TRUE, n_results = 50) {
  stopifnot(length(event_id) == 1)
  sprintf(
    "series?take=%s&eventIds[]=%s&completed=%s",
    n_results, 
    event_id,
    completed
  ) |> 
    get_ribgg_data()
}

#' Get matches
#' 
#' Get match ids for a given series
#' 
#' @param series_id Series ID
#' @return a list with the following elements: id, event_id, team1id, team2id, start_date, best_of, stage, bracket, completed, live, win_condition, vlr_id, vod_url, ggbet_id, pmt_status, pmt_reddit_url, pmt_json, event_name, event_slug, event_logo_url, parent_event_id, parent_event_name, parent_event_slug, team1, team2, matches, stats, player_stats.
#' @export
#' @examples 
#' \donttest{
#' matches <- get_matches(35225) ## Optic vs. Liquid
#' matches$matches
#' }
get_matches <- function(series_id) {
  sprintf("series/%s", series_id) |> 
    get_ribgg()
}

#' Get match details
#' 
#' Get match details for a given series
#' 
#' @return a list where each element represents a map. In each element is another list with the following elements: id, events, locations, economies.
#' @param match_id Match ID
#' @export
#' @examples 
#' \donttest{
#' match_details <- get_match_details(79018) ## Optic vs. Liquid, Map 3
#' match_details$locations
#' }
get_match_details <- function(match_id) {
  sprintf("matches/%s/details", match_id) |>
    get_ribgg()
}
