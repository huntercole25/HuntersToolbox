#' Truncate WKT-formatted tabular data decimal points
#'
#' This function decreases the number of decimal points associated with WKT coordinate strings.
#'
#' @param File A character string supplying the path to a tabular (e.g., CSV, TXT) WKT-formatted
#' providing vertices for a point, line or polygon layer.
#' @param OutputFile A character string supplying the full path to save the output file to.
#' @param Digits An integer indicating the number of decimal places to maintain.
#' @param Separator A character string indicating the column separator character used in the input file.
#'
#' @return A tabular file with WKT-formatted coordinates containing the specified number of decimal places.
#' @examples
#' \dontrun{
#' TestFile <- "C:/Users/Hunter/Documents/TestWKT.csv"
#' TestOutput <- "C:/Users/Hunter/Documents/OutputWKT.csv"
#'
#' WKT_Trunc(TestFile, TestOutput, 2, Separator = ",")
#' }
#' @export

WKT_Trunc <- function(File, OutputFile, Digits = 1, Separator = ";"){
RawWkt <- data.table::fread(File, sep = Separator, sep2 = NULL)

CoordName <- base::grep("WKT", base::names(RawWkt), value = T)

Pat <- base::paste0("(\\.\\d{", Digits, "})\\d+")

RawWkt$NewWkt <- base::gsub(Pat, "\\1", RawWkt$WKT)

NewWkt <- RawWkt[,!"WKT"]

data.table::setnames(NewWkt, "NewWkt", "WKT")

data.table::fwrite(NewWkt, OutputFile, sep = Separator)
}
