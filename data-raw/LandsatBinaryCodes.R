x <- data.table::data.table(Number = 0:(2^16-1))

BinaryCalculator_16Bit <- function(y) base::paste0(base::as.numeric(base::intToBits(y)[1:16]), collapse = "")

x$Binary <- base::apply(x, 1, BinaryCalculator_16Bit)

x$xFill <- base::substr(x$Binary, 1, 1)
x$xDilatedCloud <- base::substr(x$Binary, 2, 2)
x$xCirrus <- base::substr(x$Binary, 3, 3)
x$xCloud <- base::substr(x$Binary, 4, 4)
x$xCloudShadow <- base::substr(x$Binary, 5, 5)
x$xSnow <- base::substr(x$Binary, 6, 6)
x$xClear <- base::substr(x$Binary, 7, 7)
x$xWater <- base::substr(x$Binary, 8, 8)
x$xCloudConfidence <- base::substr(x$Binary, 9, 10)
x$xCloudShadowConfidence <- base::substr(x$Binary, 11, 12)
x$xSnowConfidence <- base::substr(x$Binary, 13, 14)
x$xCirrusConfidence <- base::substr(x$Binary, 15, 16)

LandsatBinaryCodes <- x

usethis::use_data(LandsatBinaryCodes, overwrite = TRUE)
