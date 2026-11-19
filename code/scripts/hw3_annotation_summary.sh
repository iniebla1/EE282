#!/usr/bin/env bash
# hw3_annotation_summary.sh
# Download the D. melanogaster GTF annotation from FlyBase, verify its integrity
# with an MD5 checksum, and summarize feature types and genes per chromosome arm.
#
# Requires: curl, bioawk, md5sum or md5 (macOS)
# Usage (from repo root): bash code/scripts/hw3_annotation_summary.sh

set -euo pipefail

RELEASE="r6.69"
BASE="https://s3ftp.flybase.org/genomes/Drosophila_melanogaster/current/gtf"
FILE="dmel-all-${RELEASE}.gtf.gz"
OUTDIR="data/raw"

mkdir -p "$OUTDIR"
cd "$OUTDIR"

# ---- Download ---------------------------------------------------------------
curl -sSL -o "$FILE" "$BASE/$FILE"
curl -sSL -o gtf_md5sum.txt "$BASE/md5sum.txt"

# ---- File integrity ---------------------------------------------------------
if command -v md5sum >/dev/null; then MD5="md5sum"; else MD5="md5 -r"; fi

expected=$(grep " ${FILE}$" gtf_md5sum.txt | awk '{print $1}')
observed=$($MD5 "$FILE" | awk '{print $1}')
echo "Expected MD5: $expected"
echo "Observed MD5: $observed"
if [[ "$expected" == "$observed" ]]; then
    echo "Checksum OK"
else
    echo "Checksum MISMATCH" >&2; exit 1
fi

# ---- Features of each type, most to least common ----------------------------
# $feature is the 3rd GTF column. sort | uniq -c counts, sort -rn orders by count.
echo
echo "Feature counts (most -> least common):"
bioawk -c gff '{ print $feature }' "$FILE" \
    | sort | uniq -c | sort -k1,1nr

# ---- Genes per chromosome arm -----------------------------------------------
# Keep only 'gene' records on the major arms; $seqname is the 1st GTF column.
echo
echo "Genes per chromosome arm:"
bioawk -c gff '$feature == "gene" && $seqname ~ /^(X|Y|2L|2R|3L|3R|4)$/ { print $seqname }' "$FILE" \
    | sort | uniq -c | sort -k1,1nr
