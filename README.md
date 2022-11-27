# **HuntersToolbox**

## Package Purpose

`HuntersToolbox` is a R package serving as a traveling box of accessory R functions that I use or have used on a day-to-day basis. These functions may or may not be related and have no common theme aside from being handy to me.

## Installing

While obvious, it is important to have an appropriate version of R installed on your machine. This package requires R 4.0.0 or newer. The simplest way to install `HuntersToolbox` is to use the `install_github` function from the `devtools` package. Before proceeding with this the installation of `HuntersToolbox`, you must first ensure that you have the software "Rtools" installed [(available through this link)](https://cran.r-project.org/bin/windows/Rtools/), then ensure `devtools` is installed. To install and load `devtools` then install `HuntersToolbox`, use the code below:

```{r}
install.packages("devtools")
require(devtools)
install_github(repo = "huntercole25/EcoCountHelper", build_vignettes = T)
```

## Current Functions

-   **GetAccess -** This function reads a specified MS Access table as a data table.

-   **LCP_Calc -** Uses the `movecost` package's `movecorr` function to calculate least-cost paths (LCPs) using user supplied DEM and slope layers. Users can also specify what they would like to consider a prohibitively steep slope to try and avoid steep terrain. This function is not perfect, should be used only as a tool for considering potential movement paths, and should always be examined by someone with terrain navigation experience if used for route planning.

-   **MultiMerge -** Behaves in the same way as base R's `merge` function, but allows users to specify three or more tables to merge.

-   **theme_PREM -** A simple and elegant ggplot2 theme.

-   **WKT_Trunc -** Decreases the number of decimal points associated with WKT coordinate strings.
