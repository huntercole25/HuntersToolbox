#' A simple and elegant ggplot2 theme
#'
#' A pre-packaged theme. To make inline modifications to this theme, use \code{\link[ggplot2]{theme}}.
#'
#' @examples
#' #Creating a plot with theme_nocturnal
#' library(ggplot2)
#'
#' Plot <- ggplot(cars, aes(speed, dist)) +
#'   geom_point() +
#'   theme_PREM()
#'
#' #Changing the axis text size of a theme_PREM plot
#'
#' Plot2 <- Plot +
#'   theme(axis.text = element_text(size = 4))
#' @export

theme_PREM <- function(){
  ggplot2::theme_light()+
    ggplot2::theme(axis.text = ggplot2::element_text(size = 14),
          axis.title.x = ggplot2::element_text(size = 16, face = "bold", margin = ggplot2::margin(t = 10)),
          axis.title.y = ggplot2::element_text(size = 16, face = "bold", margin = ggplot2::margin(r = 10)),
          legend.text = ggplot2::element_text(size = 12),
          legend.title = ggplot2::element_text(size = 12, face = "bold"),
          panel.grid = ggplot2::element_line(color = "white"),
          strip.background = ggplot2::element_rect(fill = "grey30"),
          strip.text = ggplot2::element_text(size = 16, face = "bold"),
          panel.spacing = ggplot2::unit(2, "lines"))
}
