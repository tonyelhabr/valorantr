test_that('prettifying nested lists works', {
  df <- tibble::tibble(
    alpha = 1,
    bRavo = 'charlie',
    deLta = tibble::tibble(
      ecHo = 'foxtrot', 
      goLf = 'hotel', 
      india = tibble::tibble(juliett = 'lima', mIke = 'november')
    ),
    oScar = list(
      list(
        'papa' = 2, 
        'quEbec' = 3, 
        'roMeo' = tibble::tibble(
          'siErra' = 4, 
          'tanGo' = list(list('uNiform' = 5, 'victor' = 'whiskey'))
        )
      )
    )
  )
  pretty_df <- prettify_nested_dfs(df)
  expected_df <- structure(
    list(
      alpha = 1, 
      b_ravo = 'charlie', 
      de_lta = structure(
        list(
          ec_ho = 'foxtrot', 
          go_lf = 'hotel', 
          india = structure(
            list(
              juliett = 'lima',
              m_ike = 'november'
            ), 
            class = c('tbl_df',  'tbl', 'data.frame'), 
            row.names = c(NA, -1L)
          )
        ), 
        row.names = c(NA, -1L), 
        class = c('tbl_df', 'tbl', 'data.frame')
      ),
      o_scar = list(
        list(
          papa = 2, 
          qu_ebec = 3, 
          ro_meo = structure(
            list(
              si_erra = 4, 
              tan_go = list(
                list(
                  u_niform = 5, victor = 'whiskey')
              )
            ), 
            row.names = c(NA, -1L), 
            class = c('tbl_df', 'tbl', 'data.frame')
          )
        )
      )
    ), 
    row.names = c(NA, -1L), 
    class = c('tbl_df', 'tbl', 'data.frame')
  )
  expect_identical(pretty_df, expected_df)
})
