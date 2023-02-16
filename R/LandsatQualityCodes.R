#' Identify appropriate Landsat quality codes
#'
#' This function parses the binary code underlying Landsat 5 and 8 "QA_PIXEL" raster values and truncates raster values
#' in accordance with user-specified conditions. Additional information about interpretting "QA_PIXEL" bit values can be
#' found \href{https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/atoms/files/LSDS-1328_Landsat8-9-OLI-TIRS-C2-L2-DFCB-v6.pdf}{here}.
#'
#' @param Fill A character vector of allowable "Fill" bit values.
#'
#' @param DilatedCloud A character vector of allowable "Dilated Cloud" bit values.
#'
#' @param Cirrus A character vector of allowable "Cirrus" bit values.
#'
#' @param Cloud A character vector of allowable "Cloud" bit values.
#'
#' @param CloudShadow A character vector of allowable "Cloud Shadow" bit values.
#'
#' @param Snow A character vector of allowable "Snow" bit values.
#'
#' @param Clear A character vector of allowable "Clear" bit values.
#'
#' @param Water A character vector of allowable "Water" bit values.
#'
#' @param CloudConfidence A character vector of allowable "Cloud Confidence" two-bit values.
#'
#' @param CloudShadowConfidence A character vector of allowable "Cloud Shadow Confidence" two-bit values.
#'
#' @param SnowConfidence A character vector of allowable "Snow/Ice Confidence" two-bit values.
#'
#' @param CirrusConfidence A character vector of allowable "Cirrus Confidence" two-bit values.
#'
#' @return This function returns a vector of integers representing "QA_PIXEL" raster values that satisfy the
#' conditions for the bit value arguments.
#'
#' @section Details:
#' \itemize{
#' \item {This function was written for Landsat 5 and 8 data, however further inspection of data format control books
#' for other Landsat datasets may reveal additional compatibility.}
#' \item {The default values for all arguments does not remove
#' any values from the potential "QA_PIXEL" values.}
#' \item {All possible QA_PIXEL raster values and their associated bit values can be found in the `LandsatBinaryCodes` dataset.}
#' }
#'
#' @examples
#' # `raster` must be attached to properly plot rasters
#' library(raster)
#'
#' # Loading example red-band (B4) and QA_PIXEL Landsat 8 rasters
#' data("ExRed", "ExQA", package = "HuntersToolbox")
#'
#' # Plotting example red-band raster
#' plot(ExRed)
#'
#' # Plotting example QA_PIXEL raster
#' plot(ExQA)
#'
#' # Producing list of possible QA_PIXEL values excluding cloud edges, clouds, and cloud shadows
#' NoCloud_Shadow <- LandsatQualityCodes(DilatedCloud = "0", Cloud = "0", CloudShadow = "0")
#'
#' # Eliminating cloud and cloud shadow pixels from QA_PIXEL raster
#' ExQA[!ExQA %in% NoCloud_Shadow] <- NA
#'
#' # Plotting QA_PIXEL raster without clouds or cloud shadows
#' plot(ExQA)
#'
#' # Removing data from red-band raster where clouds or cloud shadows were present
#' Red_NoCloud_Shadow <- mask(ExRed, ExQA)
#'
#' # Plotting red-band raster without data influenced by clouds or cloud shadows
#' plot(Red_NoCloud_Shadow)
#'
#' @export

LandsatQualityCodes <- function(Fill = c("0","1"), DilatedCloud = c("0","1"), Cirrus = c("0","1"),
                                Cloud = c("0","1"), CloudShadow = c("0","1"), Snow = c("0","1"),
                                Clear = c("0","1"), Water = c("0","1"),
                                CloudConfidence = c("00", "01", "10", "11"),
                                CloudShadowConfidence = c("00", "01", "10", "11"),
                                SnowConfidence = c("00", "01", "10", "11"),
                                CirrusConfidence = c("00", "01", "10", "11")){

  a <- which(LandsatBinaryCodes$xFill %in% Fill)
  b <- which(LandsatBinaryCodes$xDilatedCloud %in% DilatedCloud)
  c <- which(LandsatBinaryCodes$xCirrus %in% Cirrus)
  d <- which(LandsatBinaryCodes$xCloud %in% Cloud)
  e <- which(LandsatBinaryCodes$xCloudShadow %in% CloudShadow)
  f <- which(LandsatBinaryCodes$xSnow %in% Snow)
  g <- which(LandsatBinaryCodes$xClear %in% Clear)
  h <- which(LandsatBinaryCodes$xWater %in% Water)
  i <- which(LandsatBinaryCodes$xCloudConfidence %in% CloudConfidence)
  j <- which(LandsatBinaryCodes$xCloudShadowConfidence %in% CloudShadowConfidence)
  k <- which(LandsatBinaryCodes$xSnowConfidence %in% SnowConfidence)
  l <- which(LandsatBinaryCodes$xCirrusConfidence %in% CirrusConfidence)

  Keepers <- Reduce(intersect, list(a,b,c,d,e,f,g,h,i,j,k,l))

  HuntersToolbox::LandsatBinaryCodes[Keepers,][["Number"]]
}
