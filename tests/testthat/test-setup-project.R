library(testthat)
library(fs)
library(usethis)

check_dir_structure <- function(path) {
  # Check that the required directories are created
  expected_dirs <- c(
    "data",
    "raw-data",
    "Rdata",
    "R/figures",
    "R/tables",
    "R/reports",
    "results/figures"
  )
  for (dir in expected_dirs) {
    expect_true(
      object = fs::dir_exists(fs::path(path, dir)),
      info = paste("Directory", dir, "should exist")
    )
  }
}

test_that("setup_project creates the correct structure", {
  # Create a temporary directory
  temp_dir <- tempfile(pattern = "test_project")
  dir_create(temp_dir)

  # Run the setup_project function
  setup_project(temp_dir)
  check_dir_structure(temp_dir)

  # Check that the README.md file is created
  expect_true(file_exists(path(temp_dir, "README.md")), info = "README.md file should exist")

  # Clean up
  dir_delete(temp_dir)
})

test_that("setup_project works with no path given", {
  # Create a temporary directory
  temp_dir <- tempfile(pattern = "test_project")
  dir_create(temp_dir)
  # Set it as the current active project (locally)
  setwd(temp_dir)
  # Run setup_project
  setup_project()
  check_dir_structure(".")
})
