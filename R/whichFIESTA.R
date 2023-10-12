

whichFIESTA <- function(func_name) {

  FIESTAutils_contents <- readRDS(here("data/FIESTAutils_contents.csv"))
  FIESTA_contents <- readRDS(here("data/FIESTA_contents.csv"))

  full <- rbind(FIESTAtils_contents, FIESTA_contents)

  out <- full[full[["funcs"]] == func_name, ]


  if (length(out) == 0) {
    message(paste0("Could not find ", func_name, "in either FIESTA or FIESTAutils"))
    return(NULL)
  } else {
    out
  }

}


whichFIESTA("pcheck.varchar")















