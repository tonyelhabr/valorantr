test_that("get_all_x_names functions work", {
  
  test_names_f <- function(prefix, n_rows) {
    f <- sprintf("get_all_%s_names", prefix)
    res <- purrr::exec(f)
    expected_cols <- sprintf("%s%s", prefix, c("Id", "Name"))
    if (prefix == "agent") {
      expected_cols <- c(expected_cols, "roleId")
    } else if (prefix == "weapon") {
      expected_cols <- c(expected_cols, "weaponCategory")
    }
    expect_identical(colnames(res), expected_cols)
    expect_identical(nrow(res), n_rows)
  }
 
  c(
    "region" = 7L,
    "weapon" = 17L,
    "agent" = 19L,
    "map" = 8L,
    "role" = 4L,
    "armor" = 2L
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
