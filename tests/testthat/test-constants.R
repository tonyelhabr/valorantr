test_that("get_all_x_names functions work", {
  
  test_names_f <- function(prefix, n_rows) {
    f <- sprintf("get_all_%s_names", prefix)
    res <- purrr::exec(f)
    expect_identical(colnames(res), sprintf("%s%s", prefix, c("Id", "Name")))
    expect_identical(nrow(res), n_rows)
  }
 
  c(
    "region" = 7L,
    "weapon" = 17L,
    "agent" = 19L,
    "map" = 8L
  ) |> 
    purrr::iwalk(
      ~test_names_f(
        prefix = .y,
        n_rows = .x
      )
    )

  
})

test_that("get_all_team_names works", {
  # skip_on_ci()
  skip_on_cran()
  
  teams <- get_all_team_names()
  expect_identical(
    colnames(teams),
    c(
      "id",
      "name",
      "shortName",
      "countryId"
    )
  )
  
  expect_gt(
    nrow(teams),
    1000L
  )
  
})
