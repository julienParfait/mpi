
# MPI : Multidimensional Poverty Index (Alkire-Foster Method)

[![Pkgdown
site](https://img.shields.io/badge/docs-pkgdown-blue.svg)](https://julienParfait.github.io/mpi/)

The **mpi** package provides tools to compute the Multidimensional
Poverty Index (MPI) using the Alkire-Foster methodology.

It allows users to input binary deprivation indicators, assign weights,
and specify a global poverty cutoff (k). The package returns:

- A data frame with individual deprivation scores and poverty status
- A summary table with key statistics: Incidence (H), Intensity (A), and
  MPI
- An interactive **plotly** barplot of poverty status

## Installation

``` r
# Install from GitHub
# remotes::install_github("julienParfait/MPI")
```

## Example

``` r
library(mpi)

data <- data.frame(
  edu = c(1, 0, 1, 1, 0),
  health = c(0, 1, 1, 1, 0),
  water = c(1, 0, 1, 1, 1)
)

weights <- c(0.4, 0.3, 0.3)
k <- 0.33

res <- mpi(data, weights, k)

head(res$data)
```

    ##   edu health water DeprivationScore IsPoor
    ## 1   1      0     1              0.7      1
    ## 2   0      1     0              0.3      0
    ## 3   1      1     1              1.0      1
    ## 4   1      1     1              1.0      1
    ## 5   0      0     1              0.3      0

``` r
res$summary
```

    ##                                 Metric Value
    ## 1                  Headcount Ratio (H)  0.60
    ## 2                        Intensity (A)  0.90
    ## 3 Multidimensional Poverty Index (MPI)  0.54

``` r
#res$plot
```

## Output Meaning

- H (Headcount ratio): Proportion of people who are multidimensionally
  poor

- A (Intensity): Average share of deprivations among the poor

- MPI: The product of H and A
