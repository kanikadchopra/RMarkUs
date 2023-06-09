library(utils)

# Purpose: Randomized data generation

#' Data Extraction
#'
#' Extract the data from the file
#' @param filename Filename of full data set
#' @param filetype Type of file, i.e. csv, tab-delim, space-delim
#' @return The data extracted from the file as a data.frame
#' @export

extractData <- function(filename, filetype) {
  if (filetype == "csv") {
    data <- read.csv(filename)
  } else if (filetype == "space-delim") {
    data <- read.table(filename)
  } else if (filetype=="tab-delim") {
    data <- read.delim(filename)
  }
  return(data)
}

#' Random Subset
#'
#' Randomly subset data from a full dataset
#' @param filename Filename of full dataset
#' @param filetype Type of file, i.e. csv files, text files, table
#' @param n Size of dataset
#' @param variables Variables to select from data set.
#' DEFAULT is all.
#' @param seedNum Seed to randomly select data from data set
#' @return The random subset of data from the full dataset
#' @export

subsetData <- function(filename, filetype, n, variables='all', seedNum) {
  set.seed(seedNum)

  data <- extractData(filename, filetype)

  if (variables=='all'){
    randomData <- data[sample(1:nrow(data), n),]
  }
  else {
    data <- data[variables]
    randomData <- data[sample(1:nrow(data), n),]
  }

  return(randomData)
}

#' Probability Distribution
#'
#' Helper function to run the distribution function using the string name
#'
#' @param fct Probability distribution function in R as a string
#' @param ... Parameters for function
#' @return List of random values generated from probability distribution
#' @examples
#' vals1 <- run_function('rnorm', 10, 0, 1)
#' vals2 <- run_function('rbinom', 10, 2, 0.5)
#' @export
# run_function

run_function <- function(fct, ...) {
  get(fct)(...)
}

#' Generate Data
#'
#' Generate data from a random probability distribution
#' @param distribution Distribution to generate data from.
#' Options are: 'beta', 'binom', 'chisq', 'exp', 'f', 'gamma', 'geom', 'hyper',
#' 'logis', 'lnorm', 'nbinom', 'norm', 'pois', 't', 'unif', 'weibull'
#' Example: [0,1] for mean and standard deviation of Normal distribution
#' @param n Size of dataset
#' @param seedNum Seed to randomly select data from data set
#' @param ... The remaining parameters to set based on random distribution
#' @return Data frame with randomly generated data from specified probability distribution
#' @examples
#' vals1 <- generateData('norm', 10, 25, mean=0, sd=1)
#' vals2 <- generateData('binom', 10, 25, size=2, prob=0.5)
#' @export
# Generate data

generateData <- function(distribution, n, seedNum, ...){
  set.seed(seedNum)
  distr_fnc <-  paste('r', distribution, sep='')
  randomData <- run_function(distr_fnc, n, ...)

  return(as.data.frame(randomData))
}
