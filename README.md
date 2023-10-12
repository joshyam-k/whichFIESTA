
### Usage

Install using:

``` r
devtools::install_github("joshyam-k/whichFIESTA")
```

    ## Downloading GitHub repo joshyam-k/whichFIESTA@HEAD

    ## 
    ## ── R CMD build ─────────────────────────────────────────────────────────────────
    ## * checking for file ‘/private/var/folders/kd/4wp69y7d2yd3fxpd1_m64clm0000gn/T/RtmpoicTkw/remotes111a53565837c/joshyam-k-whichFIESTA-74f101f/DESCRIPTION’ ... OK
    ## * preparing ‘whichFIESTA’:
    ## * checking DESCRIPTION meta-information ... OK
    ## * checking for LF line-endings in source and make files and shell scripts
    ## * checking for empty or unneeded directories
    ## Removed empty directory ‘whichFIESTA/.github’
    ## Omitted ‘LazyData’ from DESCRIPTION
    ## * building ‘whichFIESTA_0.0.0.9000.tar.gz’

    ## Installing package into '/private/var/folders/kd/4wp69y7d2yd3fxpd1_m64clm0000gn/T/RtmpCkyswa/temp_libpath13c8e1c203d8b'
    ## (as 'lib' is unspecified)

``` r
library(whichFIESTA)
```

Run using:

``` r
whichFIESTA("pcheck.varchar")
```

    ## pcheck.varchar exists in FIESTAutils at R/pcheck.functions.R

``` r
whichFIESTA("check.rowcol")
```

    ## check.rowcol exists in FIESTA at R/check.rowcol.R

``` r
whichFIESTA("modGBpop")
```

    ## modGBpop exists in FIESTA at R/modGBpop.R
