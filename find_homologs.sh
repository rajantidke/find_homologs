#!/bin/bash

# This is to check if the user has provided the correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <query file> <subject file> <output file>"
    exit 1
fi

# This assign arguments to variables
QUERY_FILE=$1
SUBJECT_FILE=$2
OUTPUT_FILE=$3

# This will run BLAST and filter for perfect matches
blastn -query "$QUERY_FILE" -subject "$SUBJECT_FILE" -task blastn-short -outfmt "6 qseqid sseqid pident length qlen" | \
awk -v OFS='\t' '{ if ($3 == 100 && $4 == $5) print $0 }' > "$OUTPUT_FILE"

# This will count and print the number of perfect matches
MATCH_COUNT=$(wc -l < "$OUTPUT_FILE")
echo "Number of perfect matches: $MATCH_COUNT"
