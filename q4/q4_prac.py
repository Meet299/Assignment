import sys
import pandas as pd

def group_in_quantiles(n, numbers):
    # Use pandas qcut to divide the numbers into quantiles
    quantiles, bins = pd.qcut(numbers, q=n, labels=[f"q{i+1}" for i in range(n)], retbins=True)
    
    # Print each number with its quantile and the interval it belongs to
    for value, quantile in zip(numbers, quantiles):
        # Find the index of the quantile and get the corresponding bin interval
        quantile_index = int(quantile[1:]) - 1  # e.g., 'q1' -> 0, 'q2' -> 1, etc.
        print(f"{value}\t{quantile}\t{quantile} ({bins[quantile_index]:.2f}, {bins[quantile_index + 1]:.2f}]")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python group_in_quantiles.py <number_of_quantiles> <file1> <file2>")
        sys.exit(1)

    try:
        n_quantiles = int(sys.argv[1])  # Number of quantiles
        file1_name = sys.argv[2]  # First file with numbers
        file2_name = sys.argv[3]  # Second file with numbers
        
        # Read numbers from both files
        with open('first_hundred_numbers.tsv', 'r') as file1:
            numbers1 = [float(line.strip()) for line in file1]
        
        with open('q4_data.tsv', 'r') as file2:
            numbers2 = [float(line.strip()) for line in file2]
        
        # Combine the numbers from both files
        all_numbers = numbers1 + numbers2
        
        # Group numbers into quantiles
        group_in_quantiles(n_quantiles, all_numbers)
        
    except ValueError:
        print("Please provide a valid integer for the number of quantiles.")
        sys.exit(1)

