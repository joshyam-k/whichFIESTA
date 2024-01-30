#' Locate a given FIESTA or FIESTAutils function
#'
#' @param func_name A string representing the function name you wish to locate
#' @examples
#' whichFIESTA("pcheck.varchar")
#' @importFrom stringr str_extract
#' @export
whichFIESTA <- function(func_name) {

  # full_funcs_df is internal
  # you can see how it is created in data-raw/fiesta_contents.R
  # or access it using whichFIESTA:::full_funcs_df
  out <- full_funcs_df[full_funcs_df[["function_name"]] == func_name, , drop = FALSE]
  out <- unique(out)


  if (nrow(out) == 0) {
    func_scroll(found = FALSE, final_f = func_name)
    cat(" - Not found in FIESTA or FIESTAutils")
    cat("\n\n")
  } else {
    func_scroll(found = TRUE, final_f = func_name)
    Sys.sleep(0.3)
    for(i in 1:nrow(out)) {
      messaging(out[i, , drop = FALSE], func_name)
      if (i != nrow(out)) {
        cat("\n")
      }
    }
  }

  invisible(func_name)

}

messaging <- function(out, func_name) {
  expo <- ifelse(out$exported, "::", ":::")
  pkg <- str_extract(out$location, "(.*)(?=/R/)")
  path <- str_extract(out$location, paste0("(?<=", pkg, "/", ")", ".*"))
  branch <- ifelse(pkg == "FIESTA", "master", "main")
  url <- paste0("https://github.com/USDAForestService/", pkg, "/blob/", branch, "/", path)
  clickable <- cli::style_hyperlink(
    text = path,
    url = url
  )
  location <- paste0(" - Found in ", pkg, " at ", clickable)
  access_str <- paste0(pkg, expo, func_name)
  access <- paste0(" - Access using ", cli::make_ansi_style("royalblue4")(access_str))
  cat(location)
  cat("\n")
  cat(spin(2), "\r", access, sep = "")
  cat("\n\n")
}

func_scroll <- function(time = 1, n = 50, found = TRUE, final_f = NULL) {
  funcs <- sample(full_funcs_df$function_name, n, replace = FALSE)
  x <- exp(seq(0, 3, length = n + 1))
  time_vals <- (x / sum(x)) * time
  color_vals <- rep("slategray4", n)

  if (found) {
    color_vals <- c(color_vals, "green4")
    funcs <- c(funcs, paste0("\u2713", " | ", final_f))
  } else {
    color_vals <- c(color_vals, "red3")
    funcs <- c(funcs, paste0("\u2717", " | ", final_f))
  }

  size <- 0
  func <- ""
  added_reset <- nchar("Searching... ")
  purrr::pwalk(.l = list(funcs, time_vals, color_vals),
               .f = function(...) {
                 func <<- ..1
                 reset <- paste0(rep(" ", size + added_reset), collapse = " ")
                 cat("\r", reset, "\r", "Searching... ", cli::make_ansi_style(..3)(func), sep = "")
                 size <<- nchar(func)
                 Sys.sleep(..2)
               })
  Sys.sleep(0.15)
  cat("\n\n")

  invisible(func)
}


spin <- function(time = 3) {
  order_sym <- c("|", "/", "-", "\\", "|", "/", "-", "\\")
  syms <- rep(order_sym, time)
  syms <- syms[-length(syms)]
  times <- rep(1/(8 * time), times = 8*time - 1)
  size <- 0
  val <- ""
  purrr::pwalk(.l = list(syms, times),
               .f = function(...) {
                 val <<- ..1
                 reset <- paste0(rep(" ", size), collapse = " ")
                 cat("\r", reset, "\r", " ", val, sep = "")
                 size <<- nchar(val)
                 Sys.sleep(..2)
               })
  invisible(val)
}

































