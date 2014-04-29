complete <- function(directory) {
  dir <- as.character(directory)
  a <- sprintf("%03d.csv", dir)
  
  nob <- lapply(a, function(file) {
    file <- as.character(file)
    a <- read.csv(file) })
  return(nob)
}