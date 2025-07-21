#' Multidimensional Poverty Index (Alkire-Foster Method)
#'
#' This function computes the Multidimensional Poverty Index (MPI) using the Alkire-Foster methodology.
#' It takes as input a data frame of binary deprivation indicators, a vector of weights, and a global poverty cutoff `k`.
#'
#' It also returns an interactive `plotly` bar chart showing the proportions of poor and non-poor individuals.
#'
#' @param data A data.frame where each column is a binary deprivation indicator (0 = not deprived, 1 = deprived).
#' @param weights A numeric vector of weights corresponding to each indicator. Its length must equal the number of columns in `data`.
#' @param k The global poverty cutoff (between 0 and 1), above which an individual is considered multidimensionally poor.
#'
#' @return A list containing:
#' \itemize{
#'   \item \code{data} : The original data.frame, augmented with two new columns: the weighted deprivation score and the binary poverty status.
#'   \item \code{summary} : A data.frame summarizing the Headcount Ratio (H), Intensity (A), and the MPI value.
#'   \item \code{plot} : A `plotly` interactive bar chart showing the percentage of poor and non-poor individuals.
#' }
#'
#' @examples
#' data <- data.frame(
#'   edu = c(1, 0, 1, 1, 0),
#'   health = c(0, 1, 1, 1, 0),
#'   water = c(1, 0, 1, 1, 1)
#' )
#' weights <- c(0.4, 0.3, 0.3)
#' k <- 0.33
#' res <- MPI(data, weights, k)
#' head(res$data)
#' res$summary
#' res$plot
#'
#' @importFrom plotly plot_ly layout
#' @importFrom magrittr %>%
#' @export
MPI <- function(data, weights, k) {
  # Input validation
  if (!is.data.frame(data)) stop("`data` must be a data.frame.")
  if (any(!sapply(data, function(x) all(x %in% c(0, 1))))) stop("All columns in `data` must be binary (0/1) deprivation indicators.")
  if (length(weights) != ncol(data)) stop("Length of `weights` must match the number of columns in `data`.")
  if (!is.numeric(k) || k < 0 || k > 1) stop("`k` must be a number between 0 and 1.")

  # Normalize weights
  weights <- weights / sum(weights)

  # Compute weighted deprivation score for each individual
  weighted_deprivation <- as.matrix(data) %*% weights
  data$DeprivationScore <- weighted_deprivation

  # Identify multidimensionally poor individuals
  data$IsPoor <- as.numeric(weighted_deprivation >= k)

  # Compute MPI components
  H <- mean(data$IsPoor)  # Headcount ratio
  A <- ifelse(H > 0, mean(weighted_deprivation[data$IsPoor == 1]), 0)  # Intensity
  MPI_value <- H * A

  # Summary table
  summary_table <- data.frame(
    Metric = c("Headcount Ratio (H)", "Intensity (A)", "Multidimensional Poverty Index (MPI)"),
    Value = round(c(H, A, MPI_value), 4)
  )

  # Plot: percentage of poor vs. non-poor
  counts <- table(data$IsPoor)
  pct <- round(100 * prop.table(counts), 1)

  plot <- plotly::plot_ly(
    x = c("Non-poor", "Poor"),
    y = as.numeric(pct),
    type = "bar",
    text = paste0(pct, "%"),
    textposition = "outside",
    marker = list(color = c("#27AE60", "#C0392B"))
  ) %>%
    plotly::layout(
      title = list(text = "Poverty Status Distribution", font = list(size = 14)),
      xaxis = list(title = list(text = "Poverty Status", font = list(size = 12))),
      yaxis = list(title = list(text = "Percentage", font = list(size = 12))),
      uniformtext = list(minsize = 10, mode = "hide"),
      margin = list(b = 60)
    )

  # Final output
  return(list(
    data = data,
    summary = summary_table,
    plot = plot
  ))
}
