#' List tables and queries in an Access database
#'
#' This function returns all tables and queries in a specified MS Access database.
#'
#' @param Path A character string containing the path to an MS Access database.
#'
#' @param Pattern An optional regular expression used to search for table/query names.
#'
#' @return This function returns the names of all tables and queries if no pattern is
#' specified, or the names of tables and queries that match a specified pattern.
#'
#' @examples
#' \dontrun{
#' DbPath <- "C:/Users/Hunter/Documents/ExampleDb.accdb"
#'
#' # Return all table and query names
#' ListTables(DbPath)
#'
#' # Return only tbale and query names that contain the word "Rat"
#' ListTables(DbPath, "Rat")
#' }
#' @export


ListTables <- function(Path, Pattern = NULL){
  Output <- sort(odbc::dbListTables(odbc::dbConnect(drv = odbc::odbc(),
                                                    .connection_string = base::paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=",
                                                                                      Path))))
  if(!is.null(Pattern)) Output <- base::grep(Pattern, Output, value = T)

  return(Output)
}
