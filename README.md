# Scripts used for Analysis of RNA Editing Landscape in Medulloblastoma Subgroups
## RNA-seq Processing and RNA-editing Detection
Example on folder Initial_Processing
This pipeline processes paired-end RNA-seq data for **ICGC_MB** to identify candidate RNA-editing sites using the hg38 reference genome.

1. **Read trimming:** Remove adapters and low-quality bases using Trim Galore and Cutadapt.
2. **Alignment:** Align trimmed reads using STAR in two-pass mode, producing a coordinate-sorted BAM and allowing up to 20 mapping locations per read.
3. **Duplicate marking:** Mark PCR/optical duplicates using GATK MarkDuplicates without removing them.
4. **Base quality recalibration:** Perform GATK BaseRecalibrator and ApplyBQSR using known variant sites.
5. **Overlap clipping:** Clip overlapping paired-end alignments using `bam clipOverlap`.
6. **RNA-editing detection:** Run REDItools `REDItoolDenovo.py` with the reference genome, chromosome exclusion list, and configured filtering options.

## Post Detection Processing
The folder contains various scripts used for post-analysis.
