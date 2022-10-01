
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom utils URLencode

#' @importFrom httr parse_url build_url
get_ribgg <- function(endpoint, query = NULL, ...) {
  
  url <- sprintf("https://backend-prod.rib.gg/v1/%s", endpoint)
  if (!is.null(query)) {
    parsed_url <- httr::parse_url(url)
    parsed_url$query <- query
    url <- httr::build_url(parsed_url)
  }
  
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

list_to_id_df <- function(x, prefix) {
  df <- data.frame(
    "id" = unname(x),
    "name" = names(x)
  )
  colnames(df) <- c(sprintf("%sId", prefix), sprintf("%sName", prefix))
  df
}

#' Get all regions
#' 
#' Get all region info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' all_regions <- get_all_region_names()
#' dplyr::glimpse(all_regions)
get_all_region_names <- function() {
  list_to_id_df(
    c(
      "Europe" = 1,
      "North America" = 2,
      "Asia-Pacific" = 3,
      "Latin America" = 4,
      "MENA" = 5,
      "Oceana" = 6,
      "International" = 7
    ),
    prefix = "region"
  )
}

#' Get all agents
#' 
#' Get all agent info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' all_agents <- get_all_agent_names()
#' dplyr::glimpse(all_agents)
get_all_agent_names <- function() {
  list_to_id_df(
    c(
      "chamber" = 17,
      "kayo" = 16,
      "fade" = 19,
      "sova" = 4,
      "raze" = 2,
      "viper" = 6,
      "jett" = 12,
      "omen" = 11,
      "breach" = 1,
      "sage" = 9,
      "skye" = 13,
      "brimstone" = 8,
      "astra" = 15,
      "killjoy" = 5,
      "neon" = 18,
      "cyper" = 3,
      "reyna" = 10,
      "phoenix" = 7,
      "yoru" = 14
    ),
    prefix = "agent"
  )
}

#' Get agent analytics
#' 
#' Get agent analytics
#' 
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' agent_analytics <- get_agent_analytics()
#' dplyr::glimpse(agent_analytics)
#' }
get_agent_analytics <- function(map_id = NULL, region_id = NULL, event_id = NULL, role_id = NULL, patch_id = NULL) {
  q <- list(
    map_id = map_id,
    region_id = region_id,
    event_id = event_id,
    role_id = role_id,
    patch_id = patch_id
  )
  get_ribgg("analytics/agents", query = q)
}


#' Get all maps
#' 
#' Get all map info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' all_maps <- get_all_map_names()
#' dplyr::glimpse(all_maps)
get_all_map_names <- function() {
  list_to_id_df(
    c(
      "ascent" = 1,
      "haven" = 7,
      "icebox" = 4,
      "bind" = 3,
      "breeze" = 8,
      "fracture" = 9,
      "pearl" = 10,
      "split" = 2
    ),
    prefix = "map"
  )
}

#' Get composition analytics
#' 
#' Get composition analytics
#' 
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' composition_analytics <- get_composition_analytics()
#' dplyr::glimpse(composition_analytics)
#' }
get_composition_analytics <- function(map_id = NULL, region_id = NULL, event_id = NULL, role_id = NULL, patch_id = NULL) {
  q <- list(
    map_id = map_id,
    region_id = region_id,
    event_id = event_id,
    role_id = role_id,
    patch_id = patch_id
  )
  get_ribgg("analytics/compositions", query = q)
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
get_map_analytics <- function(region_id = NULL, event_id = NULL, patch_id = NULL) {
  q <- list(
    region_id = region_id,
    event_id = event_id,
    patch_id = patch_id
  )
  get_ribgg("analytics/maps", query = q)
}

#' Get all weapons
#' 
#' Get all weapon info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' all_weapons <- get_all_weapon_names()
#' dplyr::glimpse(all_weapons)
get_all_weapon_names <- function() {
  list_to_id_df(
    c(
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
    ),
    prefix = "weapon"
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
get_weapon_analytics <- function(map_id = NULL, side = NULL, region_id = NULL, event_id = NULL, role_id = NULL, patch_id = NULL) {
  q <- list(
    map_id = map_id,
    side = side,
    region_id = region_id,
    event_id = event_id,
    role_id = role_id,
    patch_id = patch_id
  )
  ## TODO: Allow for requests like this: https://backend-prod.rib.gg/v1/analytics/weapons?mapId=1&regionId=2&agentId=8&side=atk
  get_ribgg("analytics/weapons", query = q)
}

#' Get all teams
#' 
#' Get all team info
#' 
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' all_teams <- get_all_team_names()
#' dplyr::glimpse(all_teams)
#' }
get_all_team_names <- function() {
  get_ribgg("teams/all")
}

#' Get team
#' 
#' Get team info
#' 
#' @param team_id Team ID
#' @return a data.frame
#' @export
#' @examples 
#' \donttest{
#' sentinels <- get_team(388)
#' str(sentinels, max.level = 1)
#' }
get_team <- function(team_id) {
  get_ribgg(sprintf("teams/%s", team_id))
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
