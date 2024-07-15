#' Generate a script to create a table
#'
#' Create a `R` script to generate a table in a report, using the template from
#' the [lbstProject] package
#'
#' @param name Name of the table to create
#' @param id ID value used to get the caption of the table The caption will be
#'   obtained from the ToT
#' @param author Author of the script (defaults to the package creator for
#'   simplicity)
#' @export
use_table <- function(name, id, author = "Alexandre Bohyn"){
  filename <- glue::glue("R/tables/name.R")
  # Check if the script for this figure already exists
  if (fs::file_exists(filename)) {
    cli::cli_abort("File {.path filename} already exists")
  }
  # Generate the file using `usethis`-style template files from this package
  use_template(
    template = "table.R",
    save_as = filename,
    data = list(
      name = name,
      author = author,
      creation_date = format(Sys.Date(), "%d %B %Y"),
      id = id
    ),
    package = "lbstProject",
    open = TRUE
  )
}
