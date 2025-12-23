\# Methods Appendix: Bulk RNA-seq Workflows



\## Overview

This document describes bulk RNA-sequencing analysis workflows used for

read alignment, gene expression quantification, quality control,

differential expression analysis, pathway enrichment, and visualization.



The workflows are written in a methods-appendix style and emphasize

reproducibility, transparency, and analytical rationale rather than

providing a turnkey software package.



---



\## 1. High-Performance Computing Environment



All analyses were performed on a high-performance computing (HPC)

cluster using a parallel file system for fast shared storage. Long-

running pipelines were executed within persistent terminal sessions to

allow continued execution after disconnection.



Workflow execution relied on containerized software environments and

job scheduling through SLURM to ensure reproducibility and resource

control.



---



\## 2. Read Alignment and Expression Quantification



Bulk RNA-seq reads were processed using the nf-core/rnaseq pipeline.

Reads were aligned to the mouse reference genome (GRCm39) using the

splice-aware aligner STAR, and gene- and transcript-level expression

was quantified using RSEM.



Sample metadata were supplied via a structured samplesheet specifying

sample identifiers, FASTQ file paths, experimental conditions, and

replicates. Reference genome FASTA and gene annotation GTF files were

provided explicitly to ensure consistency across runs.



Quality control metrics from read preprocessing, alignment, and

quantification were aggregated using MultiQC.



---



\## 3. Count Matrix Generation and Quality Control



Gene-level count matrices produced by RSEM were merged across samples

and used as the primary input for downstream analyses. Quality control

reports were reviewed to assess read quality, alignment performance,

library complexity, and consistency across samples.



Merged count matrices were retained without additional filtering at

this stage to allow flexible downstream statistical modeling.



---



\## 4. Differential Expression Analysis



Differential gene expression analysis was performed using a DESeq2-

based statistical framework implemented through a standardized

pipeline. Experimental contrasts were explicitly defined using a

contrast table specifying reference and target conditions.



Filtering thresholds for minimum abundance, minimum sample proportion,

and fold-change were applied to improve robustness while retaining

unfiltered result tables for reporting and interpretation.



Differential expression results were generated for treated versus

control comparisons and used as input for downstream pathway analyses

and visualization.



---



\## 5. Pathway Enrichment Analyses



Pathway-level interpretation of differential expression results was

performed using both gene set enrichment analysis (GSEA) and over-

representation analysis (ORA).



Curated gene sets from MSigDB, including Hallmark pathways and Gene

Ontology Biological Process terms, were used to identify enriched

biological pathways associated with transcriptional changes.



Pathway–gene network analyses were used to visualize relationships

between enriched pathways and contributing genes.



---



\## 6. Dimensionality Reduction and Exploratory Analysis



Principal component analysis (PCA) was performed on normalized gene

expression data using centered and scaled inputs. PCA was used to

evaluate global sample relationships, detect potential outliers, and

assess condition-driven variation.



Multiple principal component combinations were examined to support

exploratory interpretation.



---



\## 7. Visualization and Reporting



Visualization outputs included:

\- Principal component analysis plots

\- Enhanced volcano plots highlighting significantly regulated genes

\- Complex heatmaps with annotated sample and gene labels



Visualizations were generated using R-based tools and formatted for

clarity and interpretability. Gene-level result tables were annotated

with gene symbols and gene types prior to reporting.



Final result tables were exported in spreadsheet-compatible formats for

review and downstream interpretation.



---



\## Notes on Reproducibility



All file paths, reference versions, and pipeline configurations are

documented for transparency. Raw FASTQ files and sensitive metadata are

intentionally excluded from this repository. Scripts reflect real

analysis workflows and may require adaptation to specific computing

environments.



