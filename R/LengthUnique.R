#' Count the number of unique values in a vector
#'
#' This function is simply a wrapper for a \code{\link[base]{unique}} call nested in a \code{\link[base]{length}} call,
#' effectively allowing users to count the number of unique values in a vector with a single function call. This is
#' particularly useful for use in \code{\link[base]{apply}}, \code{\link[base]{lapply}}, \code{\link[stats]{aggregate}}
#' and similar fuctions that require the use of a single function argument.
#'
#' @param x A vector to count the number of values in.
#'
#' @return This function returns an integer value representing the number of unique values found within the vector supplied.
#'
#' @examples
#' LengthUnique(cars$speed)
#'
#' @export
#'

LengthUnique <- function(x){
  length(unique(x))
}
