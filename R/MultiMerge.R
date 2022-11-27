#' Merge multiple data frames in one call
#'
#' This function behaves in the same way as \code{\link[base]{merge}}, but allows users to specify three or
#' more tables to merge.
#'
#' @param ... Data frames, data tables or objects to be coerced to one.
#' @param by A character string or vector containing the vector name(s) on which data frames will be merged.
#' See \code{\link[base]{merge}} for more information.
#' @param all_rows A proxy for the \code{all} argument in \code{\link[base]{merge}}.
#'
#' @return This function returns a data frame or data table joined by the vectors specified in the \code{by}
#' argument, or by all vectors that have matching values between tables is \code{by} is NULL.
#'
#' @examples
#' a <- data.frame(JoinCol = 1:3, Height = c(29, 44, 13))
#' b <- data.frame(JoinCol = 1:3, Width = c(7.2, 5, 18))
#' c <- data.frame(JoinCol = 1:3, Length = c(182, 77, 90))
#'
#' MultiMerge(a, b, c, by = "JoinCol")
#'
#' @export

MultiMerge <- function(..., by=NULL, all_rows=T){
  base::Reduce(function(...) base::merge(..., all = all_rows, by = by), base::list(...))
}
