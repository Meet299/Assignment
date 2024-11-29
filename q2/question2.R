#!/usr/bin/env Rscript

# Load necessary library
library(ggplot2)

# Read command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Get the output file name and labels from command line arguments
output_file <- args[1]
x_label <- args[2]
y_label <- args[3]
plot_title <- args[4]

# Read input data from standard input
data <- read.table(file("stdin"), header = TRUE, sep = "\t")

# Check if 'Category' column exists for grouping
if(!"Category" %in% colnames(data)) {
    stop("The data must contain a 'Category' column for grouping.")
}

# Create the plot
p <- ggplot(data, aes(x = X, y = Y, color = Category, group = Category)) +
    geom_line() +
    labs(x = x_label, y = y_label, title = plot_title) +
    theme_minimal()

# Save the plot to the file
ggsave(output_file, plot = p)

# Print confirmation message
cat("Plot saved to", output_file, "\n")

