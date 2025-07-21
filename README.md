
# MPI : Multidimensional Poverty Index (Alkire-Foster Method)

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

res <- MPI(data, weights, k)

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
res$plot
```

<div class="plotly html-widget html-fill-item" id="htmlwidget-45ec5a5fef7d9afb50c4" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-45ec5a5fef7d9afb50c4">{"x":{"visdat":{"1f0071ba3118":["function () ","plotlyVisDat"]},"cur_data":"1f0071ba3118","attrs":{"1f0071ba3118":{"x":["Non-poor","Poor"],"y":[40,60],"text":["40%","60%"],"textposition":"outside","marker":{"color":["#27AE60","#C0392B"]},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":60,"l":60,"t":25,"r":10},"title":{"text":"Poverty Status Distribution","font":{"size":14}},"xaxis":{"domain":[0,1],"automargin":true,"title":{"text":"Poverty Status","font":{"size":12}},"type":"category","categoryorder":"array","categoryarray":["Non-poor","Poor"]},"yaxis":{"domain":[0,1],"automargin":true,"title":{"text":"Percentage","font":{"size":12}}},"uniformtext":{"minsize":10,"mode":"hide"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["Non-poor","Poor"],"y":[40,60],"text":["40%","60%"],"textposition":["outside","outside"],"marker":{"color":["#27AE60","#C0392B"],"line":{"color":"rgba(31,119,180,1)"}},"type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

## Output Meaning

- H (Headcount ratio): Proportion of people who are multidimensionally
  poor

- A (Intensity): Average share of deprivations among the poor

- MPI: The product of H and A
