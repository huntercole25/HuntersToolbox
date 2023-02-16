#' Read a MS Access table as a data table
#'
#' This function reads a specified MS Access table as a data table. In a Windows OS, it requires MS Access drivers which can
#' currently be found \href{https://www.microsoft.com/en-us/download/details.aspx?id=54920}{here}. If using
#' this function causes R to crash while copying and pasting or switching tabs, consider installing Access
#' Runtime which can be found \href{https://www.microsoft.com/en-us/download/details.aspx?id=50040}{here}.
#' In a Linux OS, it requires 'mdbtools' which can be installed in the termina with "sudo apt install mdbtools".
#'
#' @param SheetName A character string matching the name of the MS Access table to be read.
#' @param Path A character string containing the path to the MS Access database within which the table
#' of interest resides.
#'
#' @return This function returns the table of interest (specified using the \code{SheetName} argument) as a
#' data table.
#'
#' @examples
#' \dontrun{
#' DbPath <- "C:/Users/Hunter/Documents/ExampleDb.accdb"
#'
#' GetAccess("Example Access Table Name", DbPath)
#' }
#' @export


GetAccess <- function(SheetName, Path){
  if(base::Sys.info()['sysname']=="Windows"){
    accdb_con <- DBI::dbConnect(drv = odbc::odbc(),
                       .connection_string = base::paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=",
                                                   Path,
                                                   ";"))

    data.table::as.data.table(DBI::dbReadTable(accdb_con, SheetName))
  }

  if(base::Sys.info()['sysname']=="Linux"){
    base::warning("When used within a Linux distribution, GetAccess can only generate character and numeric vectors. Vectors intended to be another class (e.g., Date) must be converted/created after the GetAccess call.")

    TmpFile <- base::paste0(tempfile(), ".csv")
    AccessDir <- base::dirname(Path)
    AccessFile <- base::basename(Path)
    AccessTable <- SheetName

    DirFixed <- base::gsub(" ", "\\\\ ", AccessDir)
    AccessFixed <- base::gsub(" ", "\\\\ ", AccessFile)
    TableFixed <- base::gsub(" ", "\\\\ ", AccessTable)

    SysString <- base::paste0("cd ", DirFixed, " && mdb-export ", AccessFixed, " ", TableFixed, " > ", TmpFile)

    base::system(SysString)

    base::return(data.table::fread(TmpFile))
  }

  if(!Sys.info()['sysname'] %in% c("Windows", "Linux")) stop("Your OS is incompatible with GetAccess.")

}
