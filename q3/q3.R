#!/usr/bin/env Rscript

# Load dplyr for data manipulation
library(dplyr)

# Get the input file list from arguments
args <- commandArgs(trailingOnly = TRUE)
file_list <- readLines(args[1])

# Function to merge files using dplyr
merge_files <- function(files) {
  # Read the first file
  data <- read.delim(files[1], header = FALSE, sep = "\t", stringsAsFactors = FALSE)
  # Rename the columns for clarity
  colnames(data) <- c("ID", "Sample", "Description")
  
  # Iteratively join remaining files
  for (file in files[-1]) {
    new_data <- read.delim(file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)
    # Rename the columns for clarity in the second file
    colnames(new_data) <- c("ID", "Value")
    
    # Perform inner join on the ID column
    data <- inner_join(data, new_data, by = "ID")
  }
  
  return(data)
}

# Merge the files and write to stdout
result <- merge_files(file_list)
write.table(result, "", sep = "\t", quote = FALSE, row.names = FALSE)

