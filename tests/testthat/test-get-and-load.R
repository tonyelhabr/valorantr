test_that("get_events works", {
  # skip_on_ci()
  skip_on_cran()
  
  n_results <- 3L
  events <- get_events("VALORANT Champions 2022", n_results = n_results)
  expect_identical(nrow(events), n_results)
  # expect_identical(events$id, c(1866L, 1865L, 1858L))
  
  expected_columns <- c(
    "id",
    "name",
    "shortName",
    "description",
    "logoUrl",
    "regionId",
    "countryId",
    "startDate",
    "endDate",
    "prizePool",
    "prizePoolCurrency",
    "url",
    "imageUrl",
    "winnerStageCount",
    "loserStageCount",
    "live",
    "rank",
    "vctRegions",
    "divisions",
    "pmtJson",
    "parent",
    "parentId",
    "childLabel",
    "keywords",
    "slug",
    "seriesCount",
    "importance",
    "type",
    "region",
    "country"
  )
  
  expect_setequal(colnames(events), expected_columns)
  
  ## Works without query
  n_results <- 4L
  events <- get_events(n_results = n_results)
  expect_identical(nrow(events), n_results)
  
  presaved_events <- load_valorant("events")
  expect_gt(nrow(presaved_events), 0L)
  
  defunct_columns <- c("bracketJson")
  ## some new columns may have been added since pre-saved data was last refreshed,
  ##   so just check that the pre-saved column names are a subset of the column names
  ##   that we expect to be returned from the live API
  expect_true(
    all(
      setdiff(
        colnames(presaved_events),
        defunct_columns
      ) %in% 
        expected_columns
    )
  )
})

test_that("get_series works", {
  # skip_on_ci()
  skip_on_cran()
  
  n_results <- 20L
  event_id <- 1865L
  series <- get_series(event_id, n_results = n_results)
  
  expect_identical(nrow(series), n_results)
  expect_identical(
    series$id,
    c(
      35221L,
      35222L,
      35215L,
      35216L,
      35199L,
      35157L,
      35200L,
      35123L,
      35133L,
      35156L,
      34424L,
      34425L,
      35134L,
      34427L,
      34426L,
      35122L,
      34422L,
      34423L,
      34421L,
      34420L
    )
  )
  
  expected_columns <- c(
    "id",
    "eventId",
    "team1Id",
    "team2Id",
    "team1Score",
    "team2Score",
    "startDate",
    "bestOf",
    "stage",
    "bracket",
    "completed",
    "live",
    "winCondition",
    "vlrId",
    "vodUrl",
    "ggbetId",
    "pmtStatus",
    "pmtRedditUrl",
    "pmtJson",
    "pickban",
    "eventChildLabel",
    "eventName",
    "eventRegionId",
    "eventSlug",
    "eventLogoUrl",
    "parentEventId",
    "parentEventName",
    "parentEventSlug",
    "team1",
    "team2",
    "matches"
  )
  
  expect_setequal(colnames(series), expected_columns)
  
  presaved_series <- load_valorant("series")
  expect_gt(nrow(presaved_series), 0L)
  expect_true(all(colnames(presaved_series) %in% expected_columns))
})

test_that("get_matches works", {
  # skip_on_ci()
  skip_on_cran()
  
  series_id <- 35225L
  matches <- get_matches(series_id)
  
  expect_identical(matches$id, series_id)
  expect_identical(nrow(matches$matches), 3L)
  
  expected_columns <- c(
    "id",
    "eventId",
    "team1Id",
    "team2Id",
    "team1Score",
    "team2Score",
    "startDate",
    "bestOf",
    "stage",
    "bracket",
    "completed",
    "live",
    "winCondition",
    "vlrId",
    "vodUrl",
    "ggbetId",
    "pmtStatus",
    "pmtRedditUrl",
    "pmtJson",
    "pickban",
    "eventName",
    "eventSlug",
    "eventChildLabel",
    "eventLogoUrl",
    "eventRegionId",
    "parentEventId",
    "parentEventName",
    "parentEventSlug",
    "team1",
    "team2",
    "matches",
    "stats",
    "playerStats"
  )
  
  expect_setequal(names(matches), expected_columns)
  
  presaved_matches <- load_valorant("matches")
  expect_gt(length(presaved_matches), 0L)
  defunct_columns <- c("defaultMatch")
  expect_true(
    all(
      setdiff(
        names(presaved_matches[[1]]),
        defunct_columns
      ) 
      %in% expected_columns
    )
  )
})

test_that("get_match_details works", {
  # skip_on_ci()
  skip_on_cran()
  
  match_id <- 79018L
  match_details <- get_match_details(match_id)
  expect_identical(match_details$id, match_id)
  
  expected_columns <- c(
    "id",
    "playerStats",
    "events",
    "locations",
    "economies"
  )
  
  expect_setequal(names(match_details), expected_columns)
  
  presaved_match_details <- load_valorant("match_details")
  expect_gt(length(presaved_match_details), 0L)
  expect_true(all(names(presaved_match_details[[1]]) %in% expected_columns))
})

test_that("get_player works", {
  # skip_on_ci()
  skip_on_cran()
  
  player_id <- 2841L ## fns, since he has every thing filled
  player <- get_player(player_id)
  expect_identical(player$id, player_id)
  
  expected_columns <- c(
    "id",
    "ign",
    "firstName",
    "lastName",
    "bio",
    "countryId",
    "instagramUrl",
    "liquipediaUrl",
    "twitchUrl",
    "twitterUrl",
    "youtubeUrl",
    "imageUrl",
    "firestoreId",
    "teamPlayerHistoryId",
    "teamId",
    "startDate",
    "role",
    "igl",
    "previousRiotPlayerIds",
    "team",
    "career",
    "news"
  )
  
  ## column names may be out of order due to dataframify_player
  expect_setequal(names(player), expected_columns)
  
  presaved_players <- load_valorant("players")
  expect_gt(nrow(presaved_players), 0L)
  expect_true(all(colnames(presaved_players) %in% expected_columns))
})

test_that("load_valorant works", {
  # skip_on_ci()
  skip_on_cran()
  
  expect_error(
    load_valorant("foo"),
    regexp = "does not exist"
  )
  
})
