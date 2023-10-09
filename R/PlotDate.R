#' A 'Round Down' Function for Date Class Values
#'
#' Use this function to round Date class values down to the first date of the month or year.
#'
#' @param x A Date class value or vector.
#' @param Aggregate_Unit The temporal unit that should be used for rounding date values down.
#' Currently the only acceptable values for this argument are "months" and "years".
#'
#' @examples
#' library(lubridate)
#'
#' TestVector <- ymd(c("2022-01-03", "2023-12-24"))
#'
#' PlotDate(TestVector)
#'
#' PlotDate(TestVector, Aggregate_Unit = "years")
#' @export

PlotDate <- function(x, Aggregate_Unit = "months"){
  xClass <- class(x)

  if(!xClass == "Date") stop("'x' is not a Date class object. Please make 'x' a Date class object or provide a different value for 'x'.")

  if(Aggregate_Unit == "months"){
    return(ymd(paste0(year(x), "-", month(x), "-01")))
  }

  if(Aggregate_Unit == "years"){
    return(ymd(paste0(year(x), "-01-01")))
  }

  if(!Aggregate_Unit %in% c("months", "years")){
    stop("The aggregation unit you have supplied is not 'months' or 'years'. Please specify one of these aggregation units.")
  }
}
