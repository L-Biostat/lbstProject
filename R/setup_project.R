setup_project <- function(path = ".") {
  # Setup the R project in the specified path
  usethis::create_project(
    path = path,
    rstudio = TRUE,
    open = FALSE
  )
  # Set the newly created project as the active project (needed
  # for `usethis`)
  usethis::local_project(path = path)
  # Create all directories
  dirs <- c(
    "data",
    "raw-data",
    "Rdata",
    "R/figures",
    "R/tables",
    "R/reports",
    "results/figures"
  )
  fs::dir_create(dirs, recurse = TRUE)
  # Add the README file
  usethis::use_template(
    template = "README.md",
    data = list(project = "Project Name", client = "Client Name"),
    package = "lbstProject"
  )
  # Add tables of tables (ToT) as excel file
  tot_df <- data.frame(
    id = numeric(),
    type = character(),
    name = character(),
    caption = character(),
    orientation = character()
  )
  writexl::write_xlsx(tot_df, "data/table-of-tables.xlsx")
}
