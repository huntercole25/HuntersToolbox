#' Extract a hh:mm:ss time character string with leading zeros from a POSIX class object
#'
#' This function extracts the hour, minute and second values from a PSOIX class object, separates these
#' values with colons, and adds leading zeros as necessary.
#'
#' @param DateTime A POSIX class value or vector
#'
#' @return This function returns a hh:mm:ss time character vector of the same length as `DateTime`.
#'
#' @examples
#' TimeChr(Sys.time())
#'
#' @export
#'
#'

TimeChr <- function(DateTime){
  if(!"POSIXt" %in% class(DateTime)) stop("Please make sure the object supplied to the DateTime argument is a POSIX class object")

  Hour <- lubridate::hour(DateTime)
  Min <- lubridate::minute(DateTime)
  Sec <- round(lubridate::second(DateTime))

  HourZeros <- paste0(strrep(0, 2-nchar(Hour)), Hour)
  MinZeros <- paste0(strrep(0, 2-nchar(Min)), Min)
  SecZeros <- paste0(strrep(0, 2-nchar(Sec)), Sec)

  return(paste(HourZeros, MinZeros, SecZeros, sep = ":"))
}
