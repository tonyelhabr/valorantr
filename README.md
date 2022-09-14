
<!-- README.md is generated from README.Rmd. Please edit that file -->

# valorantr

<!-- badges: start -->

[![R-CMD-check](https://github.com/tonyelhabr/valorantr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tonyelhabr/valorantr/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

`{valorantr}` wraps the hidden API of rib.gg, a site for professional
Valorant match data.

## Installation

You can install the development version of `{valorantr}` with:

``` r
remotes::install_github("tonyelhabr/valorantr")
#> Using github PAT from envvar GITHUB_PAT
#> Downloading GitHub repo tonyelhabr/valorantr@HEAD
#> cli       (3.3.0 -> 3.4.0 ) [CRAN]
#> tibble    (3.1.7 -> 3.1.8 ) [CRAN]
#> rlang     (1.0.4 -> 1.0.5 ) [CRAN]
#> lifecycle (1.0.1 -> 1.0.2 ) [CRAN]
#> dplyr     (1.0.9 -> 1.0.10) [CRAN]
#> tidyr     (1.2.0 -> 1.2.1 ) [CRAN]
#> openssl   (2.0.2 -> 2.0.3 ) [CRAN]
#> Installing 7 packages: cli, tibble, rlang, lifecycle, dplyr, tidyr, openssl
#> Installing packages into 'C:/Users/antho/AppData/Local/R/win-library/4.2'
#> (as 'lib' is unspecified)
#> 
#>   There is a binary version available but the source version is later:
#>         binary source needs_compilation
#> openssl  2.0.2  2.0.3              TRUE
#> 
#> package 'cli' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'cli'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying C:
#> \Users\antho\AppData\Local\R\win-library\4.2\00LOCK\cli\libs\x64\cli.dll to C:
#> \Users\antho\AppData\Local\R\win-library\4.2\cli\libs\x64\cli.dll: Permission
#> denied
#> Warning: restored 'cli'
#> package 'tibble' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'tibble'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying C:
#> \Users\antho\AppData\Local\R\win-library\4.2\00LOCK\tibble\libs\x64\tibble.dll
#> to C:\Users\antho\AppData\Local\R\win-library\4.2\tibble\libs\x64\tibble.dll:
#> Permission denied
#> Warning: restored 'tibble'
#> package 'rlang' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'rlang'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying C:
#> \Users\antho\AppData\Local\R\win-library\4.2\00LOCK\rlang\libs\x64\rlang.dll
#> to C:\Users\antho\AppData\Local\R\win-library\4.2\rlang\libs\x64\rlang.dll:
#> Permission denied
#> Warning: restored 'rlang'
#> package 'lifecycle' successfully unpacked and MD5 sums checked
#> package 'dplyr' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'dplyr'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying C:
#> \Users\antho\AppData\Local\R\win-library\4.2\00LOCK\dplyr\libs\x64\dplyr.dll
#> to C:\Users\antho\AppData\Local\R\win-library\4.2\dplyr\libs\x64\dplyr.dll:
#> Permission denied
#> Warning: restored 'dplyr'
#> package 'tidyr' successfully unpacked and MD5 sums checked
#> Warning: cannot remove prior installation of package 'tidyr'
#> Warning in file.copy(savedcopy, lib, recursive = TRUE): problem copying C:
#> \Users\antho\AppData\Local\R\win-library\4.2\00LOCK\tidyr\libs\x64\tidyr.dll
#> to C:\Users\antho\AppData\Local\R\win-library\4.2\tidyr\libs\x64\tidyr.dll:
#> Permission denied
#> Warning: restored 'tidyr'
#> 
#> The downloaded binary packages are in
#>  C:\Users\antho\AppData\Local\Temp\RtmpuEPn9c\downloaded_packages
#> installing the source package 'openssl'
#> Warning in i.p(...): installation of package 'openssl' had non-zero exit status
#> * checking for file 'C:\Users\antho\AppData\Local\Temp\RtmpuEPn9c\remotes42e41fa15215\tonyelhabr-valorantr-66a65f5/DESCRIPTION' ... OK
#> * preparing 'valorantr':
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> Omitted 'LazyData' from DESCRIPTION
#> * creating default NAMESPACE file
#> * building 'valorantr_0.0.1.tar.gz'
#> 
#> Installing package into 'C:/Users/antho/AppData/Local/R/win-library/4.2'
#> (as 'lib' is unspecified)
#> Warning in i.p(...): installation of package 'C:/Users/antho/AppData/Local/Temp/
#> RtmpuEPn9c/file42e4363f1b29/valorantr_0.0.1.tar.gz' had non-zero exit status
```
