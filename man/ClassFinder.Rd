% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClassFinder.R
\name{ClassFinder}
\alias{ClassFinder}
\title{Find objects of a given class in global environment}
\usage{
ClassFinder(Class, Pattern = ".", CollapseString = F)
}
\arguments{
\item{Class}{A character sting indicating what object class should be searched for.}

\item{Pattern}{A regular expression. Only names matching pattern are returned.}

\item{CollapseString}{A logical value. If \code{TRUE}, the names of objects that have
classes matching the \code{Class} argument and names matching the \code{Pattern} argument
are returned as a comma and space separated charactersting. If \code{FALSE}, the names of
objects that have classes matching the \code{Class} argument and names matching the
\code{Pattern} argument are returned as a character vector with each name being a row
in the vector. A comma and space separated character string can be helpful for copying
and pasting object names into functions with \code{...} arguments (e.g., \code{\link[usethis]{use_data}})}
}
\value{
This function returns either a character vector or comma and space separated
character string containing names of objects in the global environment that matc the
criteria specified by the \code{Class} and \code{Pattern} arguments.
}
\description{
This function searches the global environment for objects of a specified class. Users may
also specify a name pattern to match via regular expression and return results as either a
character vector or a comma and space separated character string.
}
\examples{
\dontrun{
# Finding objects of class "data.table"
ClassFinder("data.table")

# Finding objects of class "data.table" that start with "s"
ClassFinder("data.table", "^s.+")

# Finding objects of class "data.table" and returning names as a comma and space separated string
ClassFinder("data.table", CollapseString = T)
}

}
