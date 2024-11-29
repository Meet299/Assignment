# Set terminal to postscript and output to EPS file
set terminal postscript eps enhanced size 6,6 font 'Arial, 15'
set output "big_matrix.eps"

# Title and labels
set title "Heatmap of Large Matrix Data"
set xlabel "Columns"
set ylabel "Rows"

# Define x and y ranges based on her code
set xrange [0:2000]
set yrange [0:100000]

# Configure a unique color palette: purple-yellow-green
set palette defined (0 "purple", 1 "yellow", 2 "green")



# Set up heatmap style
unset key
set view map
set autoscale fix

# Add horizontal grid lines to separate clusters (adjust cluster boundaries as needed)
set style line 1 lt 1 lc rgb "black" lw 1.5
set ytics add ("" 100, "" 200, "" 300, "" 400)  # Adjust ytics based on your data

# Plot the matrix data directly from the gzipped file while skipping the header column
splot '<zcat big_data.tsv.gz | cut --complement -f1' matrix with image

# Finish
unset output

