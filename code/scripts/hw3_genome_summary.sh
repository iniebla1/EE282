#!/usr/bin/env bash
# hw3_genome_summary.sh
# Download the D. melanogaster all-chromosome FASTA from FlyBase, verify its
# integrity with an MD5 checksum, and summarize the assembly with faSize.
#
# Requires: curl, faSize (conda: ucsc-fasize), md5sum or md5 (macOS)
# Usage (from repo root): bash code/scripts/hw3_genome_summary.sh

set -euo pipefail

RELEASE="r6.69"
BASE="https://s3ftp.flybase.org/genomes/Drosophila_melanogaster/current/fasta"
FILE="dmel-all-chromosome-${RELEASE}.fasta.gz"
OUTDIR="data/raw"

mkdir -p "$OUTDIR"
cd "$OUTDIR"

# ---- Download ---------------------------------------------------------------
curl -sSL -o "$FILE" "$BASE/$FILE"
curl -sSL -o fasta_md5sum.txt "$BASE/md5sum.txt"

# ---- File integrity ---------------------------------------------------------
# md5sum is GNU coreutils; macOS ships `md5 -r` with the same "hash  file" layout.
if command -v md5sum >/dev/null; then MD5="md5sum"; else MD5="md5 -r"; fi

expected=$(grep " ${FILE}$" fasta_md5sum.txt | awk '{print $1}')
observed=$($MD5 "$FILE" | awk '{print $1}')
echo "Expected MD5: $expected"
echo "Observed MD5: $observed"
if [[ "$expected" == "$observed" ]]; then
    echo "Checksum OK"
else
    echo "Checksum MISMATCH" >&2; exit 1
fi

# ---- Genome summaries -------------------------------------------------------
# faSize reads gzipped FASTA directly. Its first line looks like:
#   <total> bases (<N> N's <ACGT> real <upper> upper <lower> lower) in <seqs> sequences in 1 files
faSize "$FILE" > genome_faSize.txt
head -n 1 genome_faSize.txt

awk 'NR==1 {
    printf "Total number of nucleotides: %s\n", $1
    printf "Total number of Ns:          %s\n", substr($3, 2)
    printf "Total number of sequences:   %s\n", $(NF-4)
}' genome_faSize.txt
