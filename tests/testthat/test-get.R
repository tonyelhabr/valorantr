test_that('get_events works', {
  skip_on_ci()
  skip_on_cran()
  
  n_results <- 3L
  events <- get_events('VALORANT Champions 2022', n_results = n_results)
  expect_identical(nrow(events), n_results)
  
  expect_identical(
    colnames(events),
    c(
      'id',
      'name',
      'short_name',
      'description',
      'logo_url',
      'region_id',
      'country_id',
      'start_date',
      'end_date',
      'prize_pool',
      'prize_pool_currency',
      'url',
      'image_url',
      'winner_stage_count',
      'loser_stage_count',
      'live',
      'rank',
      'bracket_json',
      'pmt_json',
      'parent',
      'parent_id',
      'child_label',
      'keywords',
      'slug',
      'series_count',
      'importance',
      'type',
      'region',
      'country'
    )
  )
})

test_that('get_series works', {
  skip_on_ci()
  skip_on_cran()
  
  n_results <- 3L
  event_id <- 1858L
  series <- get_series(event_id, n_results = n_results)
  
  # expect_identical(
  #   series$id,
  #   event_id
  # )
  
  expect_identical(nrow(series), n_results)
  
  expect_identical(
    colnames(series),
    c(
      'id',
      'event_id',
      'team1id',
      'team2id',
      'start_date',
      'best_of',
      'stage',
      'bracket',
      'completed',
      'live',
      'win_condition',
      'vlr_id',
      'vod_url',
      'ggbet_id',
      'pmt_status',
      'pmt_reddit_url',
      'pmt_json',
      'event_name',
      'event_slug',
      'event_logo_url',
      'parent_event_id',
      'parent_event_name',
      'parent_event_slug',
      'team1',
      'team2',
      'matches'
    )
  )
})

test_that('get_matches works', {
  skip_on_ci()
  skip_on_cran()
  
  series_id <- 35225L
  matches <- get_matches(series_id)
  
  expect_identical(
    matches$id,
    series_id
  )
  
  expect_identical(
    nrow(matches$matches),
    3L
  )

  expect_identical(
    names(matches),
    c(
      'id',
      'event_id',
      'team1id',
      'team2id',
      'start_date',
      'best_of',
      'stage',
      'bracket',
      'completed',
      'live',
      'win_condition',
      'vlr_id',
      'vod_url',
      'ggbet_id',
      'pmt_status',
      'pmt_reddit_url',
      'pmt_json',
      'event_name',
      'event_slug',
      'event_logo_url',
      'parent_event_id',
      'parent_event_name',
      'parent_event_slug',
      'team1',
      'team2',
      'matches',
      'stats',
      'player_stats'
    )
  )
})


test_that('get_matches works', {
  skip_on_ci()
  skip_on_cran()
  
  match_id <- 79018L
  match_details <- get_match_details(match_id)
  expect_identical(
    match_details$id,
    match_id
  )
  
  expect_identical(
    names(match_details),
    c(
      'id',
      'events',
      'locations',
      'economies'
    )
  )
})


