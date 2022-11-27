#' Calculate a least-cost path and write to file
#'
#' This function uses the \code{\link[movecorr]{movecost}} function to calculate least-cost paths (LCPs)
#' using user supplied DEM and slope layers. Users can also specify what they would like to consider a
#' prohibitively steep slope to try and avoid steep terrain. This function is not perfect, should be used
#' only as a tool for considering potential movement paths, and should always be examined by someone with
#' terrain navigation experience if used for route planning.
#'
#' @param StartE,StartN Numeric values indicating the starting longitude and latitude provided in the same
#' coordinate system as the DEM and slope layers.
#' @param EndE,EndN Numeric values indicating the ending longitude and latitude provided in the same
#' coordinate system as the DEM and slope layers.
#' @param Lcoord,Tcoord,Rcoord,Bcoord Numeric values indicating maximum extent longitudes and
#' latitudes to consider for the LCP. The \code{Lcoord}, \code{Tcoord}, \code{Rcoord} and \code{Bcoord}
#' arguments are associated with the west-most longitude, north-most latitude, east-most longitude and
#' south-most latitude to consider, respectively.
#' @param ResampleFactor A numeric value or \code{NA} used to specify the factor by which the DEM layer's
#' cells should be increased by for resampling. This is meant to reduce computational
#' load. If no resampling is required, use \code{NA}. For most accurate results, use the lowest resampling
#' factor possible, or no resampling factor \code{NA}.
#' @param DtmPath A character string supplying the path to the DEM layer.
#' @param SlopePath A character string supplying the path to the slope layer using degrees for slope units,
#' and using the same CRS as the DEM layer.
#' @param SaveDir A character string supplying the path to the directory the LCP should be saved to.
#' @param FileName A character string supplying the base file name for LCP shapefile components.
#' @param SteepAngle A numeric value indicating the minimum angle (in degrees) that should be considered
#' prohibitively steep. If no terrain is to be considered prohibitively steep, use a value >90.
#' @param CostFun A character string supplying the cost function to be used. For details about cost function
#' options, see \code{\link[movecost]{movecorr}}.
#'
#' @return This function returns a shapefile representing the calculated LCP that can be read into R or
#' a GIS program (e.g., QGIS, ArcMap).
#'
#' @examples
#' \dontrun{
#' DemPath <- "C:/Users/Hunter/SciDem.tif"
#' Slope <- "C:/Users/Hunter/SciSlope.tif"
#'
#' SaveFolder <- "C:/Users/Hunter/Lcp"
#'
#' LCP_Calc(365556, 3639062,
#'          365644, 3638898,
#'          364974, 3639623,
#'          365868, 3638111,
#'          ResampleFactor = 1.5,
#'          DtmPath = DemPath,
#'          SlopePath = Slope,
#'          SaveDir = SaveFolder,
#'          FileName = "TestLCP",
#'          SteepAngle = 60)
#' }
#'
#' @export

LCP_Calc <- function(StartE, StartN, EndE, EndN, Lcoord, Tcoord, Rcoord, Bcoord, ResampleFactor = NA,
                           DtmPath, SlopePath, SaveDir, FileName,
                           SteepAngle = 99,
                           CostFun = "ree"){
  Dtm <- raster::raster(DtmPath)

  Dtm <- raster::crop(Dtm, raster::extent(Lcoord, Rcoord, Bcoord, Tcoord))

  Slope <- raster::raster(SlopePath)
  names(Slope) <- "Slp_mxm"

  Slope <- raster::crop(Slope, raster::extent(Dtm))

  SlopeEdit <- Slope

  try(SlopeEdit[SlopeEdit >= SteepAngle] <- NA, silent = T)

  Dtm <- raster::mask(Dtm, SlopeEdit)

  NaCells <- raster::Which(is.na(Dtm), T)

  Dtm[NaCells] <- stats::rnorm(base::length(NaCells), 10000, 10000)

  if(is.na(ResampleFactor) == F){
    base::print("Resampling DTM.")
    Dtm <- raster::aggregate(Dtm, ResampleFactor)
  }


  Start <- data.table::data.table(Easting = StartE, Northing = StartN, Name = "Start")

  End <- data.table::data.table(Easting = EndE, Northing = EndN, Name = "End")

  StartShp <- sp::SpatialPointsDataFrame(Start[,c("Easting", "Northing")], Start,
                                     proj4string = raster::crs("+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs "))

  EndShp <- sp::SpatialPointsDataFrame(End[,c("Easting", "Northing")], End,
                                   proj4string = raster::crs("+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs "))

  StartTime <- base::Sys.time()

  base::print(base::paste("Data prepped. Starting LCP analysis at", StartTime))

  TestCorr <- movecost::movecorr(Dtm, StartShp, EndShp, funct = CostFun, N = 2.1, sl.crit = SteepAngle)

  LineTab <- sp::coordinates(TestCorr$lcp_a_to_b)[[1]][[1]]

  LineList <- sp::SpatialLinesDataFrame(sp::SpatialLines(base::list(sp::Lines(base::list(sp::Line(base::cbind(LineTab[1:2,1], LineTab[1:2,2]))), 1)),
                                                 proj4string = raster::crs("+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs ")),
                                    data = data.table::data.table(FID = 1))

  for(i in 2:(nrow(LineTab)-1)){
    Tmp <- sp::SpatialLinesDataFrame(sp::SpatialLines(base::list(sp::Lines(base::list(sp::Line(base::cbind(LineTab[base::seq(i,i+1),1], LineTab[seq(i,i+1),2]))), 1)),
                                              proj4string = raster::crs("+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs ")),
                                 data = data.table::data.table(FID = i))

    LineList <- base::c(LineList, Tmp)
  }

  ExplodeLine <- base::do.call("rbind", LineList)

  PathWithSlope <- raster::extract(Slope, ExplodeLine, max, along = T, sp = T)

  rgdal::writeOGR(PathWithSlope, SaveDir, FileName, driver = "ESRI Shapefile")

  EndTime <- base::Sys.time()

  TotalTime <- base::as.numeric(EndTime) - base::as.numeric(StartTime)

  base::print(base::paste("LCP analysis and maximum slope extraction complete. Time elapsed:", TotalTime, "seconds."))
}

