test_that("get_events works", {
  skip_on_ci()
  skip_on_cran()
  
  n_results <- 3L
  events <- get_events("VALORANT Champions 2022", n_results = n_results)
  expect_identical(nrow(events), n_results)
  # expect_identical(events$id, c(1866L, 1865L, 1858L))
  
  expect_identical(
    colnames(events),
    c(
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
      "bracketJson",
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
  )
})

test_that("get_series works", {
  skip_on_ci()
  skip_on_cran()
  
  n_results <- 3L
  event_id <- 1858L
  series <- get_series(event_id, n_results = n_results)
  
  expect_identical(nrow(series), n_results)
  expect_identical(series$id, c(35332L, 35309L, 35252L))
  
  expect_identical(
    colnames(series),
    c(
      "id",
      "eventId",
      "team1Id",
      "team2Id",
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
      "eventName",
      "eventSlug",
      "eventLogoUrl",
      "parentEventId",
      "parentEventName",
      "parentEventSlug",
      "team1",
      "team2",
      "matches"
    )
  )
})

test_that("get_matches works", {
  skip_on_ci()
  skip_on_cran()
  
  series_id <- 35225L
  matches <- get_matches(series_id)
  
  expect_identical(matches$id, series_id)
  expect_identical(nrow(matches$matches), 3L)

  expect_identical(
    names(matches),
    c("id",
      "eventId",
      "team1Id",
      "team2Id",
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
      "eventName",
      "eventSlug",
      "eventLogoUrl",
      "parentEventId",
      "parentEventName",
      "parentEventSlug",
      "team1",
      "team2",
      "matches",
      "stats",
      "playerStats"
    )
  )
})


test_that("get_matches works", {
  skip_on_ci()
  skip_on_cran()
  
  match_id <- 79018L
  match_details <- get_match_details(match_id)
  expect_identical(match_details$id, match_id)
  
  expect_identical(
    names(match_details),
    c(
      "id",
      "events",
      "locations",
      "economies"
    )
  )
})


