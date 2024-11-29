import sys

def load_patterns(query_file):
    """Load patterns from the query file."""
    with open(query_file, 'r') as f:
        return {line.strip() for line in f if line.strip()}

def match_line(line, patterns):
    """Check if any pattern matches any column in the line."""
    return any(pattern in line for pattern in patterns)

query_file = "to_select.tsv"
patterns = load_patterns(query_file)

for line in sys.stdin:
    if match_line(line.strip(), patterns):
        print(line.strip())

