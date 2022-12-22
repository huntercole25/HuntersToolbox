#' Find objects of a given class in global environment
#'
#' This function searches the global environment for objects of a specified class. Users may
#' also specify a name pattern to match via regular expression and return results as either a
#' character vector or a comma and space separated character string.
#'
#' @param Class A character sting indicating what object class should be searched for.
#' @param Pattern A regular expression. Only names matching pattern are returned.
#' @param CollapseString A logical value. If \code{TRUE}, the names of objects that have
#' classes matching the \code{Class} argument and names matching the \code{Pattern} argument
#' are returned as a comma and space separated charactersting. If \code{FALSE}, the names of
#' objects that have classes matching the \code{Class} argument and names matching the
#' \code{Pattern} argument are returned as a character vector with each name being a row
#' in the vector. A comma and space separated character string can be helpful for copying
#' and pasting object names into functions with \code{...} arguments (e.g., \code{\link[usethis]{use_data}})
#'
#' @return This function returns either a character vector or comma and space separated
#' character string containing names of objects in the global environment that matc the
#' criteria specified by the \code{Class} and \code{Pattern} arguments.
#'
#' @examples
#' \dontrun{
#' # Finding objects of class "data.table"
#' ClassFinder("data.table")
#'
#' # Finding objects of class "data.table" that start with "s"
#' ClassFinder("data.table", "^s.+")
#'
#' # Finding objects of class "data.table" and returning names as a comma and space separated string
#' ClassFinder("data.table", CollapseString = T)
#' }
#'
#' @export

ClassFinder <- function(Class, Pattern = ".", CollapseString = F){
  Query <- data.table::as.data.table(sapply(sapply(ls(pos = .GlobalEnv, pattern = Pattern), get),
                                inherits, Class), keep.rownames = T)

  if(length(Query)==1){
    print("No objects meeting these criteria were found in the global environment.")
  }else{
    if(CollapseString == F){
      Query[V2 == T, V1]
    }else{
      paste(Query[V2 == T, V1], collapse = ", ")
    }
  }
}
