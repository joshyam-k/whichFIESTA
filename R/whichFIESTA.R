#' Locate a given FIESTA or FIESTAutils function
#'
#' @param func_name A string representing the function name you wish to locate
#' @examples
#' whichFIESTA("pcheck.varchar")
#' @importFrom here here
#' @importFrom stringr str_extract
#' @export
whichFIESTA <- function(func_name) {

  # full_funcs_df is internal
  # you can see how it is created in data-raw/fiesta_contents.R
  out <- full_funcs_df[full_funcs_df[["function_name"]] == func_name, , drop = FALSE]
  out <- unique(out)

  if (nrow(out) == 0) {
    stop(paste0("Could not find function ", "'", func_name, "'", " in either FIESTA or FIESTAutils"))
  } else {
    pkg <- str_extract(out$location, "(.*)(?=/R/)")
    path <- str_extract(out$location, paste0("(?<=", pkg, "/", ")", ".*"))
    out_text <- paste0(func_name, " exists in ", pkg, " at ", path)
    message(out_text)
  }

}

















