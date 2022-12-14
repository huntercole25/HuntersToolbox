% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LengthUnique.R
\name{LengthUnique}
\alias{LengthUnique}
\title{Count the number of unique values in a vector}
\usage{
LengthUnique(x)
}
\arguments{
\item{x}{A vector to count the number of values in.}
}
\value{
This function returns an integer value representing the number of unique values found within the vector supplied.
}
\description{
This function is simply a wrapper for a \code{\link[base]{unique}} call nested in a \code{\link[base]{length}} call,
effectively allowing users to count the number of unique values in a vector with a single function call. This is
particularly useful for use in \code{\link[base]{apply}}, \code{\link[base]{lapply}}, \code{\link[stats]{aggregate}}
and similar fuctions that require the use of a single function argument.
}
\examples{
LengthUnique(cars$speed)

}
