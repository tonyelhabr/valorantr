
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom utils URLencode

get_ribgg <- function(x, ...) {
  url <- sprintf("https://backend-prod.rib.gg/v1/%s", x)
  resp <- httr::GET(url, ...) 
  content <- httr::content(resp, as = "text")
  jsonlite::fromJSON(content)
}

get_ribgg_data <- function(...) {
  resp <- get_ribgg(...)
  
  if (isTRUE(getOption("valorantr.verbose"))) {
    message(sprintf('Total of %s possible results.', resp$meta$total))
  }
  
  resp[["data"]]
}

#' Get all maps
#' 
#' Get all map info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' all_maps <- get_all_maps()
#' dplyr::glimpse(all_maps)
get_all_maps <- function() {
  l <- c(
    "ascent" = 1,
    "haven" = 7,
    "icebox" = 4,
    "bind" = 3,
    "breeze" = 8,
    "fracture" = 9,
    "pearl" = 10,
    "split" = 2
  )
  data.frame(
    "weaponId" = unname(l),
    "weaponName" = names(l)
  )
}

#' Get map analytics
#' 
#' Get map analytics
#' 
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' map_analytics <- get_map_analytics()
#' dplyr::glimpse(map_analytics)
#' }
get_map_analytics <- function() {
  get_ribgg("analytics/maps")
}

#' Get all weapons
#' 
#' Get all weapon info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' all_weapons <- get_all_weapons()
#' dplyr::glimpse(all_weapons)
get_all_weapons <- function() {
  l <- c(
    "vandal" = 4,
    "phantom" = 6,
    "classic" = 11,
    "spectre" = 18,
    "sheriff" = 13,
    "ghost" = 12,
    "operator" = 15,
    "bulldog" = 5,
    "frenzy" = 10,
    "stinger" = 19,
    "guardian" = 16,
    "marshal" = 17,
    "judge" = 8,
    "shorty" = 14,
    "odin" = 2,
    "bucky" = 9,
    "ares" = 3
  )
  data.frame(
    "weaponId" = unname(l),
    "weaponName" = names(l)
  )
}

#' Get weapon analytics
#' 
#' Get weapon analytics
#' 
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' weapon_analytics <- get_weapon_analytics()
#' dplyr::glimpse(weapon_analytics)
#' }
get_weapon_analytics <- function() {
  get_ribgg("analytics/weapons")
}

#' Get all teams
#' 
#' Get all team info
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
#' yay <- get_player(2716)
#' dplyr::glimpse(yay)
#' }
get_player <- function(player_id) {
  url <- sprintf("players/%s", player_id) 
  get_ribgg(url)
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
get_events <- function(query = NULL, ..., sort_by = "startDate", ascending = FALSE, has_series = TRUE, n_results = 50) {
  
  if (!is.null(query)) {
    stopifnot(
      is.character(query),
      length(query) == 1
    )
    
    query <- sprintf("query=%s", URLencode(query))
  } else {
    query <- ""
  }

  url <- sprintf(
    "events?%ssort=%s&sortAscending=%s&hasSeries=%s&take=%s", 
    query,
    sort_by,
    tolower(ascending),
    tolower(has_series),
    n_results
  )
  
  get_ribgg_data(url)
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
  url <- sprintf(
    "series?take=%s&eventIds[]=%s&completed=%s",
    n_results, 
    event_id,
    completed
  )
  get_ribgg_data(url)
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
  url <- sprintf("series/%s", series_id) 
  get_ribgg(url)
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
  url <- sprintf("matches/%s/details", match_id)
  get_ribgg(url)
}
