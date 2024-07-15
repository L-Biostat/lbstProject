#' Save a plot with verbose
#'
#' Save a plot object as a png file and as a rds object with a verbose output
#' specifying the path of the saved files. The plot is saved in the
#' `results/figures` folder using [ggsave][ggplot2::ggsave], and the data file of the
#' plot is saved in the `Rdata/figures` folder using [saveRDS][base::saveRDS].
#'
#' @param name Name of the plot that will be used to name the files generated
#'   while saving the plot object and its data.
#' @param verbose Boolean. Display information about the path of the saved
#'   files. Default is TRUE.
#' @param ... Other arguments passed on to the [ggsave][ggplot2::ggsave] function.
#' @export
verbose_ggsave <- function(plot, name, verbose = TRUE, ...){
  filename <- glue::glue("results/figures/{name}.png")
  datafilename <- glue::glue("Rdata/figures/{name}.rds")
  ggplot2::ggsave(filename = filename, plot = plot, ...)
  saveRDS(object = plot, file = datafilename)
  if (verbose) {
    cli::cli_bullets(
      c(
        "v" = "Plot {.var {name}} saved to file {.path {filename}}",
        "v" = "Plot data saved to {.path {datafilename}}"
      )
    )
  }
}
