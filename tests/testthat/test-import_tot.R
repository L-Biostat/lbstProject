library(testthat)
library(readxl)
library(cli)
library(withr)

# Function for creating a temporary Excel file
create_temp_excel <- function(data) {
  temp_file <- tempfile(fileext = ".xlsx")
  writexl::write_xlsx(data, temp_file)
  return(temp_file)
}

test_that("import_tot function works correctly with valid input", {
  temp_file <- create_temp_excel(data.frame(
    id = 1:3,
    name = c("table1", "figure1", "table2"),
    type = c("table", "figure", "table"),
    orientation = c("landscape", "portrait", "landscape"),
    caption = c("Table 1 caption", "Figure 1 caption", "Table 2 caption")
  ))

  expect_error(import_tot(temp_file), NA)
})

test_that("import_tot function throws error on duplicate names", {
  temp_file <- create_temp_excel(data.frame(
    id = 1:3,
    name = c("table1", "table1", "table2"),
    type = c("table", "figure", "table"),
    orientation = c("landscape", "portrait", "landscape"),
    caption = c("Table 1 caption", "Figure 1 caption", "Table 2 caption")
  ))

  expect_error(import_tot(temp_file), "Duplicate names found")
})

test_that("import_tot function throws error on invalid types", {
  temp_file <- create_temp_excel(data.frame(
    id = 1:3,
    name = c("table1", "figure1", "table2"),
    type = c("table", "invalid_type", "table"),
    orientation = c("landscape", "portrait", "landscape"),
    caption = c("Table 1 caption", "Figure 1 caption", "Table 2 caption")
  ))

  expect_error(import_tot(temp_file), "Invalid types found")
})

test_that("import_tot function throws error when missing required columns", {
  temp_file <- create_temp_excel(data.frame(
    id = 1:3,
    name = c("table1", "figure1", "table2")
  ))

  expect_error(import_tot(temp_file), "ToT file should contain the following columns")
})

test_that("import_tot function throws error on invalid orientations", {
  temp_file <- create_temp_excel(data.frame(
    id = 1:3,
    name = c("table1", "figure1", "table2"),
    type = c("table", "figure", "table"),
    orientation = c("landscape", "invalid_orientation", "landscape"),
    caption = c("Table 1 caption", "Figure 1 caption", "Table 2 caption")
  ))

  expect_error(import_tot(temp_file), "Invalid orientations found")
})

test_that("import_tot function throws error on invalid names", {
  temp_file <- create_temp_excel(data.frame(
    id = 1:3,
    name = c("table1", "figure@1", "table2"),
    type = c("table", "figure", "table"),
    orientation = c("landscape", "portrait", "landscape"),
    caption = c("Table 1 caption", "Figure 1 caption", "Table 2 caption")
  ))

  expect_error(import_tot(temp_file), "Invalid names found")
})
