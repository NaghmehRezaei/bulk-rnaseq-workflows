#!/bin/bash

# Bulk RNA-seq alignment and quantification using nf-core/rnaseq
# STAR alignment + RSEM quantification

nextflow run nf-core/rnaseq -r 3.19.0 \
  --input samplesheet.csv \
  --aligner star_rsem \
  --outdir results \
  --genome null \
  --fasta /path/to/GRCm39.primary_assembly.genome.fa.gz \
  --gtf /path/to/gencode.vM37.primary_assembly.annotation.gtf \
  -profile singularity \
  -c nfcore_slurm.config
