# want a function that takes as input the name of a function and will tell you
# whether it exists in FIESTAutils or FIESTA. If it exists in at least one, then it
# will tell you which file within 'package'/R/ it exists in

library(gh)
library(purrr)
library(stringr)
library(curl)
library(openssl)

R_tree <- gh("GET /repos/{owner}/{repo}/git/trees/{tree_sha}",
             owner = "USDAForestService",
             repo = "FIESTAutils",
             tree_sha = "ba5a35986510d6970f718e8987f691b07f72359e")

name_and_sha <- function(tree) {
  data.frame(f_name = tree$path, f_sha = tree$sha)
}

R_folder_meta <- R_tree$tree %>%
  map_dfr(name_and_sha)

get_file_contents <- function(f_name, f_sha) {

  blob <- gh("GET /repos/{owner}/{repo}/git/blobs/{file_sha}",
             owner = "USDAForestService",
             repo = "FIESTAutils",
             file_sha = f_sha)

  base64_contents <- base64_decode(blob[["content"]])
  clean_contents <-  paste0(sapply(base64_contents, rawToChar), collapse = '')

  out <- list(clean_contents)
  names(out) <- f_name
  out

}

files_and_contents <- R_folder_meta %>%
  map2(.x = R_folder_meta$f_name,
       .y = R_folder_meta$f_sha,
       .f =  ~ get_file_contents(.x, .y))

files_and_contents[[1]]








