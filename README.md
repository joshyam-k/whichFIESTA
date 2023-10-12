
### Usage

Install using:

``` r
devtools::install_github("joshyam-k/whichFIESTA")
```

    ## 
    ## ── R CMD build ─────────────────────────────────────────────────────────────────
    ## * checking for file ‘/private/var/folders/kd/4wp69y7d2yd3fxpd1_m64clm0000gn/T/RtmpigRqfN/remotes1383f2f91524b/joshyam-k-whichFIESTA-864e988/DESCRIPTION’ ... OK
    ## * preparing ‘whichFIESTA’:
    ## * checking DESCRIPTION meta-information ... OK
    ## * checking for LF line-endings in source and make files and shell scripts
    ## * checking for empty or unneeded directories
    ## Removed empty directory ‘whichFIESTA/.github’
    ## Omitted ‘LazyData’ from DESCRIPTION
    ## * building ‘whichFIESTA_0.0.0.9000.tar.gz’

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
