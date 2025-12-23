# 🧬 Bulk RNA-seq Workflows

A curated collection of **bulk RNA-seq analysis workflows** built around
nf-core pipelines and downstream R-based analyses.

📄 **Complete analytical methods are documented in
[`METHODS.md`](METHODS.md).**

---

## ✨ What this repository provides

This repository presents a **methods-appendix–style documentation** of
bulk RNA-seq workflows, with an emphasis on:

- Reproducibility and transparency  
- Clear analytical rationale  
- Separation of computational methods from biological interpretation  

The workflows reflect **real analysis pipelines used in research
settings**, rather than simplified tutorials or software packages.

---

## 🧭 Workflow scope

The documented workflows cover:

- Read alignment and expression quantification  
- Quality control and count matrix generation  
- Differential expression analysis  
- Pathway enrichment (GSEA and ORA)  
- Exploratory analysis and visualization  

Each stage is described conceptually in `METHODS.md`, with scripts
provided as supporting evidence.

---

## 📌 Intended audience

This repository is designed for:

- Faculty search committees  
- Principal investigators  
- Computational collaborators  
- Trainees seeking methodological clarity  

It is **not** intended to function as a one-click executable pipeline.

---

## 🔬 Reproducibility note

Raw sequencing data and sensitive metadata are intentionally excluded.
Scripts may require adaptation to specific datasets or computing
environments.

---

## 📊 PI-facing outputs

The workflow produces concise, review-ready outputs intended for rapid
interpretation by principal investigators, including:

- Ranked pathway summary tables (NES, direction, FDR)
- GSEA and ORA dot plots
- Pathway heatmaps and enrichment maps

These outputs are designed for direct use in slides, reports, and
collaborative discussions.

