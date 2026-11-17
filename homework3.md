# Homework 3: Pipelines

All analyses use the *Drosophila melanogaster* genome from the current FlyBase release (**r6.69**), downloaded from
<https://s3ftp.flybase.org/genomes/Drosophila_melanogaster/current/>.

## Scripts

| Script | Purpose |
|---|---|
| [`code/scripts/hw3_genome_summary.sh`](code/scripts/hw3_genome_summary.sh) | Download the genome FASTA, verify its checksum, summarize it with `faSize` |
| [`code/scripts/hw3_annotation_summary.sh`](code/scripts/hw3_annotation_summary.sh) | Download the GTF annotation, verify its checksum, summarize it with `bioawk` |

## Software environment

The tools were installed into a conda environment from bioconda:

```bash
conda create -n ee282 -c conda-forge -c bioconda ucsc-fasize bioawk
conda activate ee282
```

Both scripts are run from the repository root and save downloads to `data/raw/`, which `.gitignore` excludes:

```bash
bash code/scripts/hw3_genome_summary.sh
bash code/scripts/hw3_annotation_summary.sh
```

---

## Part 1: Summarize Genome Assembly

**File:** `dmel-all-chromosome-r6.69.fasta.gz` (from the `fasta/` directory)
**Script:** [`code/scripts/hw3_genome_summary.sh`](code/scripts/hw3_genome_summary.sh)

### File integrity

FlyBase provides a `md5sum.txt` file in the same directory. The script downloads it and compares the expected hash with the MD5 of the downloaded file. It uses `md5sum` when available, and on macOS it falls back to `md5 -r`, which prints the same format.

```bash
expected=$(grep " ${FILE}$" fasta_md5sum.txt | awk '{print $1}')
observed=$($MD5 "$FILE" | awk '{print $1}')
[[ "$expected" == "$observed" ]] && echo "Checksum OK"
```

```
Expected MD5: bfa02cd8cead5a2be98b5b416aea89b4
Observed MD5: bfa02cd8cead5a2be98b5b416aea89b4
Checksum OK
```

The checksums match, so the file downloaded intact.

### Calculating the summaries

`faSize` reads the gzipped FASTA directly. The first line of its output gives the totals:

```
143726002 bases (1152978 N's 142573024 real 142573024 upper 0 lower) in 1870 sequences in 1 files
```

The script uses `awk` to pull the requested values out of that line:

```bash
faSize "$FILE" > genome_faSize.txt
awk 'NR==1 {
    printf "Total number of nucleotides: %s\n", $1
    printf "Total number of Ns:          %s\n", substr($3, 2)
    printf "Total number of sequences:   %s\n", $(NF-4)
}' genome_faSize.txt
```

### Results

| Summary | Value |
|---|---|
| Total number of nucleotides | **143,726,002** |
| Total number of Ns | **1,152,978** |
| Total number of sequences | **1,870** |

---

## Part 2: Summarize an Annotation File

**File:** `dmel-all-r6.69.gtf.gz` (from the `gtf/` directory)
**Script:** [`code/scripts/hw3_annotation_summary.sh`](code/scripts/hw3_annotation_summary.sh)

### File integrity

This check works the same way as in Part 1, using the `md5sum.txt` file from the `gtf/` directory:

```
Expected MD5: 348148581b678d50d73b1f78a6cb1920
Observed MD5: 348148581b678d50d73b1f78a6cb1920
Checksum OK
```

The checksums match, so the file downloaded intact.

### Total number of features of each type

`bioawk -c gff` parses the GTF columns by name and reads the gzipped file directly. The script prints the feature column (`$feature`, which is column 3). It then sorts the values so that `uniq -c` can count identical lines, which have to be next to each other. Finally, it sorts the counts numerically in descending order.

```bash
bioawk -c gff '{ print $feature }' dmel-all-r6.69.gtf.gz \
    | sort | uniq -c | sort -k1,1nr
```

| Feature | Count |
|---|---:|
| exon | 190,183 |
| CDS | 163,381 |
| 5UTR | 46,858 |
| 3UTR | 33,779 |
| start_codon | 30,923 |
| stop_codon | 30,863 |
| mRNA | 30,838 |
| gene | 17,872 |
| ncRNA | 3,059 |
| miRNA | 485 |
| pseudogene | 365 |
| tRNA | 312 |
| snoRNA | 270 |
| pre_miRNA | 262 |
| rRNA | 115 |
| snRNA | 32 |

### Total number of genes per chromosome arm

The script keeps only records whose feature type is `gene` and whose sequence name (`$seqname`, column 1) is one of the main chromosome arms. This leaves out unplaced scaffolds and mitochondrial sequences. It then counts the genes on each arm.

```bash
bioawk -c gff '$feature == "gene" && $seqname ~ /^(X|Y|2L|2R|3L|3R|4)$/ { print $seqname }' dmel-all-r6.69.gtf.gz \
    | sort | uniq -c | sort -k1,1nr
```

| Chromosome arm | Genes |
|---|---:|
| 3R | 4,226 |
| 2R | 3,649 |
| 2L | 3,508 |
| 3L | 3,481 |
| X | 2,704 |
| 4 | 114 |
| Y | 113 |
