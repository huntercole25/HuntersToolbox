# **HuntersToolbox**

<a href="https://zenodo.org/badge/latestdoi/268901372"><img src="https://zenodo.org/badge/268901372.svg" alt="DOI"/></a>

## Package Purpose

`HuntersToolbox` is a R package serving as a traveling box of accessory R functions that I use or have used on a day-to-day basis. These functions may or may not be related and have no common theme aside from being handy to me.

## Installing

While obvious, it is important to have an appropriate version of R installed on your machine. This package requires R 4.0.0 or newer. The simplest way to install `HuntersToolbox` is to use the `install_github` function from the `devtools` package. Before proceeding with this the installation of `HuntersToolbox`, you must first ensure that you have the software "Rtools" installed [(available through this link)](https://cran.r-project.org/bin/windows/Rtools/), then ensure `devtools` is installed. To install and load `devtools` then install `HuntersToolbox`, use the code below:

`{install.packages("devtools")} require(devtools) install_github(repo = "huntercole25/HuntersToolbox")`

## Current Functions

-   **ClassFinder -** Identifies objects of a specified class in the global environment with an optional pattern argument.

-   **GetAccess -** This function reads a specified MS Access table as a data table.

-   **ListTables** **-** This function returns all tables and queries in a specified MS Access database.

-   **LandsatQualityCodes -** This function parses the binary code underlying Landsat 5 and 8 "QA_PIXEL" raster values and truncates raster values in accordance with user-specified conditions.

-   **LengthUnique -** This function is simply a wrapper for a `unique` call nested in a length call, effectively allowing users to count the number of unique values in a vector with a single function call. This is particularly useful for use in `apply`, `lapply`, `aggregate` and similar fuctions that require the use of a single function argument.

-   **MultiMerge -** Behaves in the same way as base R's `merge` function, but allows users to specify three or more tables to merge.

-   **PlotDate -** Use this function to round Date class values down to the first date of the month or year.

-   **theme_PREM -** A simple and elegant ggplot2 theme.

-   **TimeChr -** This function extracts the hour, minute and second values from a POSIX class object, separates these values with colons, and adds leading zeros as necessary.

-   **WKT_Trunc -** Decreases the number of decimal points associated with WKT coordinate strings.
