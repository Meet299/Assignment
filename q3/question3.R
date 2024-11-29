#!/usr/bin/env Rscript

# Load necessary library
library(tidyverse)

# Get the input file list from arguments
args <- commandArgs(trailingOnly = TRUE)
file_list <- readLines(args[1])

# Read and merge all files by the first column
merge_files <- function(files) {
  data <- read.delim(files[1], header = TRUE, sep = "\t", stringsAsFactors = FALSE)
  for (file in files[-1]) {
    new_data <- read.delim(file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
    data <- inner_join(data, new_data, by = names(data)[1])
  }
  data
}

# Merge files and print the result
result <- merge_files(file_list)
write.table(result, "", sep = "\t", quote = FALSE, row.names = FALSE)

