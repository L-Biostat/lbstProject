#' Retrieve the caption of an object
#'
#' Given the ID of an object, retrieve the corresponding caption in the ToT (table of tables), that must be located in the `Rdata/tot.rds` file.
#'
#' @param id ID of the object (table or figure).
#' @export
get_caption <- function(id){
  # Import ToT if it is not already loaded
  if (!exists("tot")) {
    tot <- readRDS("Rdata/tot.rds")
  }
  # Check if the given id is in the table
  if (!(id %in% tot$id)) {
    cli::cli_abort("Given ID '{id}' is not in the Table of tables")
  }
  # Filter the ToT on the id and give the corresponding caption
  info <- tot[tot$id == id,]
  info$caption
}
