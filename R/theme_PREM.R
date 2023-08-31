#' A simple and elegant ggplot2 theme
#'
#' A pre-packaged theme. To make inline modifications to this theme, use \code{\link[ggplot2]{theme}}.
#'
#' @param MajorGrid A character string specifying the color of major grid lines.
#' @param MinorGrid A character string specifying the color of minor grid lines.
#'
#' @examples
#' #Creating a plot with theme_PREM
#'
#' library(ggplot2)
#'
#' Plot <- ggplot(cars, aes(speed, dist)) +
#'   geom_point() +
#'   theme_PREM()
#'
#' #Creating a plot with visible grid lines
#'
#' PlotLines <- ggplot(cars, aes(speed, dist)) +
#'   geom_point() +
#'   theme_PREM(MajorGrid = "grey90", MinorGrid = "grey95")
#'
#' #Changing the axis text size of a theme_PREM plot
#'
#' Plot2 <- Plot +
#'   theme(axis.text = element_text(size = 4))
#' @export

theme_PREM <- function(MajorGrid = "white", MinorGrid = "white"){
  ggplot2::theme_light()+
    ggplot2::theme(axis.text = ggplot2::element_text(size = 14),
          axis.title.x = ggplot2::element_text(size = 16, face = "bold", margin = ggplot2::margin(t = 10)),
          axis.title.y = ggplot2::element_text(size = 16, face = "bold", margin = ggplot2::margin(r = 10)),
          legend.text = ggplot2::element_text(size = 12),
          legend.title = ggplot2::element_text(size = 12, face = "bold"),
          panel.grid.major = ggplot2::element_line(color = MajorGrid),
          panel.grid.minor = ggplot2::element_line(color = MinorGrid),
          strip.background = ggplot2::element_rect(fill = "grey30"),
          strip.text = ggplot2::element_text(size = 16, face = "bold"),
          panel.spacing = ggplot2::unit(2, "lines"))
}
