#' Import the Table of Tables (ToT) from an Excel file
#'
#' This function imports a Table of Tables (ToT) from an Excel file, validates
#' the data, and optionally provides verbose output about the import process.
#' The function performs multiple checks on the data, which are described below.
#' The imported data is saved as an RDS file.
#'
#' @param tot_xlsx_path A character string specifying the path to the Excel file
#'   containing the Table of Tables. Default is the file located at
#'   "data/tot/table-of-tables.xlsx".
#' @param verbose A logical indicating whether to print verbose output during
#'   the import process. Default is FALSE.
#'
#' @return A data frame. The ToT import from the excel file. However, the
#'   function is mainly used for its side effects: importing,validating, and
#'   saving the ToT data, and optionally printing verbose output.
#'
#' @details The function performs the following checks on the ToT:
#' \itemize{
#'   \item Required columns (`id`, `name`, `type`, `orientation`, `caption`)
#'     are present.
#'   \item There are no duplicate names or IDs.
#'   \item Names only contain lowercase and uppercase letters (a-z, A-Z),
#'     digits (0-9), and dashes (-).
#'   \item The `type` column contains only "figure" or "table".
#'   \item The `orientation` column contains only "landscape" or "portrait".
#' }
#'
#' @examples
#' \dontrun{
#' # Example usage with default path and verbose output
#' import_tot(verbose = TRUE)
#'
#' # Example usage with a specified file path
#' import_tot(tot_xlsx_path = "path/to/your/table-of-tables.xlsx", verbose = TRUE)
#' }
#'
#' @export
import_tot <- function(
    tot_xlsx_path = here::here("data/tot/table-of-tables.xlsx"),
    verbose = FALSE) {
  if (verbose) {
    # Global header for batch run if verbose
    cli::cli_h1("Importing ToT")
  }
  # Import Excel file
  tot <- readxl::read_excel(tot_xlsx_path)

  # Check that "id", "name", "type", "orientation", "caption" are columns in the
  # ToT
  tot_cols <- c("id", "name", "type", "orientation", "caption")
  if (any(!(tot_cols %in% colnames(tot)))) {
    cli::cli_abort("ToT file should contain the following columns: {.val {tot_cols}}")
  }

  # Check that there are not duplicate names or ID
  dup_names <- duplicated(tot$name)
  if (any(dup_names)) {
    cli::cli_abort("Duplicate names found: {.val {tot$name[dup_names]}}")
  }

  dup_id <- duplicated(tot$id)
  if (any(dup_id)) {
    cli::cli_abort("Duplicate ID found: {.val {tot$id[dup_id]}}")
  }

  # Check that names only contain a-z 0-9 and dashes
  invalid_names <- !stringr::str_detect(tot$name, "^[A-z0-9\\-]+$")
  if (any(invalid_names)) {
    cli::cli_abort("Invalid names found: {.val {tot$name[invalid_names]}}")
  }

  # Check that type is either "figure" or "table"
  invalid_types <- !tot$type %in% c("figure", "table")
  if (any(invalid_types)) {
    cli::cli_abort("Invalid types found: {.val {tot$type[invalid_types]}}")
  }

  # Check that the orientation is either "landscape" or "portrait"
  invalid_orientations <- !tot$orientation %in% c("landscape", "portrait")
  if (any(invalid_orientations)) {
    cli::cli_abort("Invalid orientations found: {.val {tot$orientation[invalid_orientations]}}")
  }

  # Save as rds file
  tot_rds_path <- here::here("Rdata/tot.rds")
  # Output ToT info if verbose
  if (verbose) {
    cli::cli_bullets(
      c(
        "v" = "ToT imported to {.path {tot_rds_path}}",
        "i" = "{nrow(tot)} entr{?y/ies} found:",
        "*" = "{sum(tot$type == 'table')} table{?s}",
        "*" = "{sum(tot$type == 'figure')} figure{?s}"
      )
    )
  }

  # Return the freshly imported dataset
  tot
}
