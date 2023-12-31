library(gh)
library(openssl)
library(purrr)
library(stringr)
library(usethis)
library(dplyr)
library(tidyr)
library(FIESTA)
library(FIESTAutils)

R_tree_FIESTAutils <- gh("GET /repos/{owner}/{repo}/contents/{path}",
                         owner = "USDAForestService",
                         repo = "FIESTAutils",
                         path = "R/")

R_tree_FIESTA <- gh("GET /repos/{owner}/{repo}/contents/{path}",
                    owner = "USDAForestService",
                    repo = "FIESTA",
                    path = "R/")


name_and_sha <- function(tree) {
  data.frame(f_name = tree$path, f_sha = tree$sha)
}

R_folder_FIESTAutils <- R_tree_FIESTAutils |>
  map_dfr(name_and_sha)

R_folder_FIESTA <- R_tree_FIESTA |>
  map_dfr(name_and_sha)

get_file_contents <- function(f_name, f_sha, repo) {

  blob <- gh("GET /repos/{owner}/{repo}/git/blobs/{file_sha}",
             owner = "USDAForestService",
             repo = repo,
             file_sha = f_sha)

  base64_contents <- base64_decode(blob[["content"]])
  clean_contents <-  paste0(sapply(base64_contents, rawToChar), collapse = '')

  out <- list(clean_contents)
  names(out) <- f_name
  out

}

FIESTAutils_cont <- R_folder_FIESTAutils |>
  map2(.x = R_folder_FIESTAutils$f_name,
       .y = R_folder_FIESTAutils$f_sha,
       .f =  ~ get_file_contents(.x, .y, repo = "FIESTAutils"))

FIESTA_cont <- R_folder_FIESTA |>
  map2(.x = R_folder_FIESTA$f_name,
       .y = R_folder_FIESTA$f_sha,
       .f =  ~ get_file_contents(.x, .y, repo = "FIESTA"))

get_function_names <- function(contents) {

  func_names <- str_extract_all(
    contents[[1]],
    "((?<=\n?).*)(?=\\s?<-\\s?function\\s?\\()"
  )

  out <- str_trim(func_names[[1]], side = "both")

  out[out != ""]

}

full_extract <- function(x, package) {

  file <- names(x)
  funcs <- get_function_names(x)
  num_funcs <- length(funcs)

  out <- data.frame(
    location = rep(paste0(package, "/", file), num_funcs),
    function_name = funcs
  )

  out

}

FIESTAutils_df <-
  map_dfr(.x = FIESTAutils_cont,
          .f = ~ full_extract(.x, package = "FIESTAutils"))

FIESTA_df <-
  map_dfr(.x = FIESTA_cont,
          .f = ~ full_extract(.x, package = "FIESTA"))

# remove commented out functions
full_funcs_df <- rbind(FIESTA_df, FIESTAutils_df) |>
  filter(!str_detect(function_name, "#"))


export_info <- data.frame(
  function_name = unique(c(ls("package:FIESTA"), ls("package:FIESTAutils"))),
  exported = TRUE
)


full_funcs_df <- full_funcs_df |>
  left_join(export_info, by = "function_name") |>
  mutate(exported = replace_na(exported, FALSE))


usethis::use_data(full_funcs_df, overwrite = TRUE, internal = TRUE)
