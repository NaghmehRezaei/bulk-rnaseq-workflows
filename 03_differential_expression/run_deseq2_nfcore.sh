#!/bin/bash

# Differential expression analysis using nf-core/differentialabundance

nextflow run nf-core/differentialabundance -r 1.5.0 \
  --input samplesheet.csv \
  --contrasts contrast.tsv \
  --matrix rsem.merged.gene_counts.tsv \
  --outdir deseq2_results \
  -profile rnaseq,singularity \
  -c nfcore_slurm.config
