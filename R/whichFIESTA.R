#' @importFrom here here
#' @export
whichFIESTA <- function(func_name) {


  out <- full_funcs_df[full_funcs_df[["function_name"]] == func_name, ]


  if (length(out) == 0) {
    message(paste0("Could not find ", func_name, "in either FIESTA or FIESTAutils"))
    return(NULL)
  } else {
    out
  }

}

















