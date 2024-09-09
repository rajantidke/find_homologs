#!/usr/bin/env bash


# Usage must be : ./find_homologs.sh <query_file> <subject_file> <output_file>
# We'll check the correctness of the number arguments in the following snippet.

if [ "$#" -ne 3 ]; then
    echo "Usage: ./find_homologs.sh <query_file> <subject_file> <output_file>"
    exit 1
fi

query_file=$1
subject_file=$2
output_file=$3

# This perform a tblastn search using the query protein sequence against the nucleotide subject
tblastn -query "$query_file" -subject "$subject_file" -out blast_results.txt -outfmt "6 qseqid sseqid pident length qlen" 

# This filter for hits with >30% identity and >90% match length
awk '{if ($3 > 30 && $4 > 0.9 * $5) print $0}' blast_results.txt > "$output_file"