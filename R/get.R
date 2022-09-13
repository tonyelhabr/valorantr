
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names make_clean_names
#' @importFrom utils URLencode

get_ribgg <- function(x, ...) {
  sprintf('https://backend-prod.rib.gg/v1/%s', x) |> 
    httr::GET(...) |> 
    httr::content(as = 'text') |> 
    jsonlite::fromJSON()
}

prettify_df <- function(df) {
  df |> 
    tibble::as_tibble() |> 
    janitor::clean_names()
}

prettify_nested_dfs <- function(x) {
  
  nms <- names(x)
  if (length(nms) > 0) {
    names(x) <- janitor::make_clean_names(nms)
  }
  
  nms <- colnames(x)
  if (length(nms) > 0) {
    x <- janitor::clean_names(x)
  }
  
  is_df <- is.data.frame(x)
  is_lst <- is.list(x)
  if (isFALSE(is_df) & isFALSE(is_lst)) {
    return(x)
  }
  
  if (isTRUE(is_df)) {
    clss <- purrr::map(x, class)
    clss_w_df <- clss |> purrr::keep(~any(.x == 'data.frame'))
    
    if (length(clss_w_df) > 0) {
      cols <- names(clss_w_df)
      for(col in cols) {
        x[[col]] <- prettify_nested_dfs(x[[col]])
      }
    }
    
    clss_w_lst <- clss |> purrr::keep(~any(.x == 'list'))
    
    if (length(clss_w_lst) > 0) {
      cols <- names(clss_w_lst)
      for(col in cols) {
        x[[col]] <- list(prettify_nested_dfs(x[[col]]))
      }
    }
  }
  x
}

get_ribgg_data <- function(...) {
  get_ribgg(...) |> 
    pluck('data') |> 
    prettify_df()
}

get_nested_ribgg_data <- function(...) {
  get_ribgg(...) |> 
    prettify_nested_dfs()
}

get_all_teams <- function() {
  get_ribgg('teams/all') |> 
    prettify_df()
}

get_player <- function(player_id) {
  sprintf('players/%s', player_id) |> 
    get_nested_ribgg_data()
}

get_events <- function(query, ..., sort_by = 'startDate', ascending = FALSE, has_series = TRUE, n_results = 50) {
  stopifnot(
    is.character(query),
    length(query) == 1
  )
  sprintf(
    'events?query=%s&sort=%s&sortAscending=%s&hasSeries=%s&take=%s', 
    URLencode(query),
    sort_by,
    tolower(ascending),
    tolower(has_series),
    n_results
  ) |> 
    get_ribgg_data()
}

get_series <- function(event_id, ..., completed = TRUE, n_results = 50) {
  stopifnot(length(event_id) == 1)
  sprintf(
    'series?take=%s&eventIds[]=%s&completed=%s',
    n_resuls, 
    event_id,
    completed
  ) |> 
    get_ribgg_data()
}

get_matches <- function(series_id) {
  sprintf('series/%s', series_id) |> 
    get_nested_ribgg_data()
}

get_match_details <- function(match_id) {
  sprintf('matches/%s/details', match_id) |>
    get_nested_ribgg_data()
}
