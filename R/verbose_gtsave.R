#' Save a gt table with verbose
#'
#' Save a gt table (created with the [gt] package) as a single docx file, and
#' also as a rds object with a verbose output specifying the path of the saved
#' files. The plot is saved in the `results/tables` folder using
#' [gtsave][gt::gtsave], and the data file of the plot is saved in the
#' `Rdata/tables` folder using [saveRDS][base::saveRDS].
#'
#' @param data The gt table data object, commonly created through the use of the
#'   [gt()] function.
#' @param name Name of the plot that will be used to name the files generated
#'   while saving the plot object and its data.
#' @param extension Extension defining the output to which the table will be
#'   saved. Accepted extensions are `.html`, `.tex`, `.ltx`, `.rtf`, `.docx`.
#' @param verbose Boolean. Display information about the path of the saved
#'   files. Default is TRUE.
#' @param ... Other arguments passed on to the [gtsave][gt::gtsave] function.
#' @export
verbose_gtsave <- function(data, name, extension = "docx", verbose = TRUE, ...){
  filename <- glue::glue("results/tables/{name}.{extension}")
  datafilename <- glue::glue("Rdata/tables/{name}.rds")
  gt::gtsave(data = data, filename = filename, ...)
  saveRDS(object = data, file = datafilename)
  if (verbose) {
    cli::cli_bullets(
      c(
        "v" = "Table {.var {name}} saved to file {.path {filename}}",
        "v" = "Table data saved to {.path {datafilename}}"
      )
    )
  }
}
