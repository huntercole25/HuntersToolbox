#' A function for retrieving ENSO region 3.4 SST anomaly data from a NOAA server
#'
#' This function retrieves mean monthly sea surface temperature anomaly data for ENSO region 3.4 from a
#' \href{https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt}{NOAA server}.
#'
#' @param StartDate A character string specifying the start date for data to be returned in ymd format.
#' @param EndDate A character string specifying the end date for data to be returned in ymd format.
#'
#' @return A data table containing a year vector ("YR"; integer), a month vector("MON"; integer),
#' a mean sea surface temperature (SST) vector ("TOTAL"; numeric), a \href{https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_change.shtml}{centered 30-year month-specific base period SST value}
#' ("ClimAdjust"; numeric), an SST anomaly value ("ANOM"; numeric), and a date-class vector representing the first day of the month and year
#' indicated by the "MON" and "YR" vectors ("Date", Date).
#'
#' @examples
#' #Retrieving data using default dates
#'
#' SST_3.4()
#'
#' #Retrieving data from June 2023 through July 2024
#'
#' SST_3.4("2023-06-01", "2024-07-01")
#'
#' @export

SST_3.4 <- function(StartDate = "1970-01-01", EndDate = "2024-08-01"){
  OniHistoric <- data.table::fread("https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt")

  OniHistoric$Date <- lubridate::ymd(base::paste(OniHistoric$YR, OniHistoric$MON, "01", sep = "-"))

  base::return(OniHistoric[OniHistoric$Date >= lubridate::ymd(StartDate) & OniHistoric$Date <= lubridate::ymd(EndDate),])
}
